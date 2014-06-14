class MessagesController < ApplicationController
  before_action :load_community_from_subdomain
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @messages = @community.messages.order("created_at desc").all
    @tab_name = "messages"
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @tab_name = "messages"
  end

  # GET /messages/new
  def new
    if @community.people.count > 0
      @message = current_user.messages.new
      if params[:message_to]
        @message.person_ids = params[:message_to]
      end

      if params[:bulk_recipients].present?
        @people = @community.people.select {|p| p.companies.where(:company_type => params[:bulk_recipients]).present?}
        @message.people = @people
      elsif params[:bulk_employees].present?
        @people = @community.people.where(:is_employee => true)
        @message.people = @people
      end
    else
      redirect_to new_person_path, :notice => "You need atleast one person in order to send a message."
    end
      

    @tab_name = "messages"
  end

  # GET /messages/1/edit
  def edit
    @tab_name = "messages"
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = current_user.messages.new(message_params)
    @message.community = @community

    respond_to do |format|
      if @message.save
        @message.people.each do |person|
          PeopleMailer.new_message(@message, person, current_user).deliver
        end
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = @community.messages.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:subject,
                                      :body,
                                      :user_id,
                                      { :person_ids => [] })
    end
end
