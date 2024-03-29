class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_filter :load_noteable, :only => [:create, :destroy, :index]
  before_action :load_community_from_subdomain, :only => [:index]

  # GET /notes
  # GET /notes.json
  def index
    @notes = @noteable.notes.all

    resource, id = request.path.split('/')[1, 2]
    
    @tab_name         = "#{resource.singularize.pluralize}"
    @page_title       = "Notes"
    @page_subtitle    = "#{@noteable.name}"
    @page_description = ""

    add_breadcrumb "Home", community_home_path, :title => "#{@community.name} Home"
    add_breadcrumb "People", people_path, :title => "#{@community.name} People"
    add_breadcrumb "#{@noteable.name}", polymorphic_url(@noteable), :title => "#{@noteable.name} within #{@community.name}"
    add_breadcrumb "Notes", request.original_url, :title => "#{@noteable.name} Notes from #{@community.name}"
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = @noteable.notes.new(note_params)
    @note.user  = current_user

    respond_to do |format|
      if @note.save
        format.html { redirect_to polymorphic_url(@noteable), notice: 'Note was successfully created.' }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to polymorphic_url(@noteable), notice: 'Note was successfully updated.' }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to polymorphic_url(@noteable), notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def load_noteable
      resource, id = request.path.split('/')[1, 2]
      @noteable = resource.singularize.classify.constantize.friendly.find(id)
    rescue
      @noteable = Community.find_by_subdomain!(request.subdomain)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:body, :reminder_ds, :reminder_sent_dts, :user_id, :attachment, :noteable_id, :noteable_type)
    end
end
