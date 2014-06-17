class PeopleController < ApplicationController
  before_action :authenticate_user!
  before_action :load_community_from_subdomain
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "Home", :community_home_path

  # GET /people
  # GET /people.json
  def index
    if params[:person_type] == "customers"
      @search = @community.people.where(:is_employee => false).search(params[:q])
    elsif params[:person_type] == "coworkers"
      @search = @community.people.where(:is_employee => true).search(params[:q])
    else
      @search = @community.people.search(params[:q])
    end
      @people = @search.result

    @tab_name         = "people"
    @page_title       = ""
    @page_subtitle    = ""
    @page_description = ""

    add_breadcrumb "People", people_path, :title => "#{@community.name} People"
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @noteable   = @person
    @note       = @person.notes.new
    @notes      = @person.notes.order("created_at desc")

    @tab_name         = "people"
    @page_title       = ""
    @page_subtitle    = ""
    @page_description = ""

    add_breadcrumb "People", people_path, :title => "#{@community.name} People"
    add_breadcrumb "#{@person.name}", person_path(@person), :title => "#{@person.name} within #{@community.name}"
  end

  # GET /people/new
  def new
    @person = @community.people.new
    @person.build_address
    @person.digital_addresses.build
    @person.companies.build
    @person.employments.build
    
    @tab_name         = "people"
    @page_title       = ""
    @page_subtitle    = ""
    @page_description = ""

    add_breadcrumb "People", people_path, :title => "#{@community.name} People"
    add_breadcrumb "New", new_person_path, :title => "New People"
  end

  # GET /people/1/edit
  def edit
    @person.companies.build
    unless @person.employments.present?
      @person.employments.build
    end
    unless @person.address.present?
      @person.build_address
    end

    @tab_name         = "people"
    @page_title       = ""
    @page_subtitle    = ""
    @page_description = ""

    add_breadcrumb "People", people_path, :title => "#{@community.name} People"
    add_breadcrumb "#{@person.name}", person_path(@person), :title => "#{@person.name} within #{@community.name}"
    add_breadcrumb "Edit", edit_person_path(@person), :title => "Edit #{@person.name} within #{@community.name}"
  end

  # POST /people
  # POST /people.json
  def create
    @person = @community.people.new(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to person_path(@person), notice: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to person_path(@person), notice: 'Person was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = @community.people.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:name,
                                     :bio,
                                     :is_employee,
                                     :date_of_birth,
                                     :gender,
                                     :photo,
                                     :remote_photo_url,
                                     :slug,
                                     companies_attributes: [:id, :name],
                                     digital_addresses_attributes: [:id, :name, :address_type, :url],
                                     employments_attributes: [:id, :company_id, :role],
                                     address_attributes: [:id, :street_line_1, :street_line_2, :city, :state, :zip])
    end
end
