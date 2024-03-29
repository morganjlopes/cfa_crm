class MessagesController < ApplicationController
  before_action :load_community_from_subdomain

  add_breadcrumb "Home", :community_home_path

  # GET /messages
  # GET /messages.json
  def index
    if params[:person_id].present?
      @person = Person.friendly.find(params[:person_id])
      @messages = @person.messages.order("created_at desc").all

      @page_subtitle    = "#{@person.name}"

      add_breadcrumb "People", people_path, :title => "#{@community.name} People"
      add_breadcrumb "#{@person.name}", person_path(@person), :title => "#{@person.name} within #{@community.name}"
      add_breadcrumb "Messages", person_messages_path(@person), :title => "#{@community.name} Messages"
    else
      @messages = @community.messages.order("created_at desc").all

      @page_subtitle    = "Providing Constant Contact"

      add_breadcrumb "Messages", messages_path, :title => "#{@community.name} Messages"
    end
    
    @tab_name         = "messages"
    @page_title       = "Messages"
    @page_description = ""
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    if params[:person_id].present?
      @person = Person.friendly.find(params[:person_id])
      @message = @person.messages.find(params[:id])

      add_breadcrumb "People", people_path, :title => "#{@community.name} People"
      add_breadcrumb "#{@person.name}", person_path(@person), :title => "#{@person.name} within #{@community.name}"
      add_breadcrumb "Messages", person_messages_path(@person), :title => "#{@community.name} Messages"
      add_breadcrumb "'#{@message.subject}'", message_path(@message), :title => "#{@message.subject}"
    else
      @message = @community.messages.find(params[:id])
      
      add_breadcrumb "Messages", messages_path, :title => "#{@community.name} Messages"
      add_breadcrumb "'#{@message.subject}'", message_path(@message), :title => "#{@message.subject}"
    end

    @tab_name         = "messages"
    @page_title       = "'#{@message.subject}'"
    @page_subtitle    = "Message from #{@message.user.email}"
    @page_description = ""
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
      
    @tab_name         = "messages"
    @page_title       = "New Message"
    @page_subtitle    = ""
    @page_description = ""

    add_breadcrumb "Messages", messages_path, :title => "#{@community.name} Messages"
    add_breadcrumb "New", new_message_path, :title => "New #{@community.name} Message"
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
