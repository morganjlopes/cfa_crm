class CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_community_from_subdomain
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "Home", :community_home_path

  # GET /companies
  # GET /companies.json
  def index
    if params[:company_type]
      @search = @community.companies.where(:company_type => params[:company_type]).search(params[:q])
    else
      @search = @community.companies.search(params[:q])
    end
    @companies = @search.result

    @tab_name         = "companies"
    @page_title       = "Companies"
    @page_subtitle    = "Loyal Businesses"
    @page_description = ""

    add_breadcrumb "Companies", companies_path, :title => "#{@community.name} Companies"
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    @noteable   = @company
    @note       = @company.notes.new
    @notes      = @company.notes.order("created_at desc")

    @tab_name         = "companies"
    @page_title       = "#{@company.name}"
    @page_subtitle    = "Connected on #{@company.created_at.strftime("%b %e, %Y")}"
    @page_description = ""

    add_breadcrumb "Companies", companies_path, :title => "#{@community.name} Companies"
    add_breadcrumb "#{@company.name}", company_path(@company), :title => "#{@company.name} with #{@community.name}"
  end

  # GET /companies/new
  def new
    @company = @community.companies.new
    @company.build_address
    @company.digital_addresses.build
    
    @tab_name         = "companies"
    @page_title       = "New Company"
    @page_subtitle    = ""
    @page_description = ""

    add_breadcrumb "Companies", companies_path, :title => "#{@community.name} Companies"
    add_breadcrumb "New", new_company_path, :title => "New Company within #{@community.name}"
  end

  # GET /companies/1/edit
  def edit
    unless @company.address.present?
      @company.build_address
    end

    unless @company.digital_addresses.present?
      @company.digital_addresses.build
    end
    
    @tab_name         = "companies"
    @page_title       = "Edit #{@company.name}"
    @page_subtitle    = "Update Company Information"
    @page_description = ""

    add_breadcrumb "Companies", companies_path, :title => "#{@community.name} Companies"
    add_breadcrumb "#{@company.name}", company_path(@company), :title => "#{@company.name} with #{@community.name}"
    add_breadcrumb "Edit", edit_company_path(@company), :title => "Edit #{@company.name} with #{@community.name}"
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = @community.companies.new(company_params)

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = @community.companies.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name,
                                      :bio,
                                      :slug,
                                      :company_type,
                                      :photo,
                                      :remote_photo_url,
                                      digital_addresses_attributes: [:id, :name, :address_type, :url],
                                      address_attributes: [:id, :street_line_1, :street_line_2, :city, :state, :zip])
    end
end
