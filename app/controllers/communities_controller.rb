class CommunitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_community_from_subdomain, only: [:show, :edit, :update]
  before_action :ensure_user_can_edit_community, only: [:edit, :update]

  # GET /communities
  # GET /communities.json
  def index
    @communities = current_user.communities.all

    @page_title       = ""
    @page_subtitle    = ""
    @page_description = ""
  end

  # GET /communities/1
  # GET /communities/1.json
  def show
    @noteable   = @community
    @note       = @community.notes.new
    @notes      = @community.notes.order("created_at desc")

    @tab_name         = "community_home"
    @page_title       = ""
    @page_subtitle    = ""
    @page_description = ""
  end

  # GET /communities/new
  def new
    @community = Community.new
    @community.owner = current_user
    @community.user_ids = [current_user.id]
    @community.build_address
    @community.digital_addresses.build

    @page_title       = ""
    @page_subtitle    = ""
    @page_description = ""
  end

  # GET /communities/1/edit
  def edit
    unless @community.address.present?
      @community.build_address
    end

    @page_title       = ""
    @page_subtitle    = ""
    @page_description = ""
  end

  # POST /communities
  # POST /communities.json
  def create
    @community = Community.new(community_params)

    respond_to do |format|
      if @community.save
        format.html { redirect_to community_home_path(:subdomain => @community.subdomain), notice: 'Community was successfully created.' }
        format.json { render :show, status: :created, location: @community }
      else
        format.html { render :new }
        format.json { render json: @community.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /communities/1
  # PATCH/PUT /communities/1.json
  def update
    respond_to do |format|
      if @community.update(community_params)
        format.html { redirect_to community_home_path(:subdomain => @community.subdomain), notice: 'Community was successfully updated.' }
        format.json { render :show, status: :ok, location: @community }
      else
        format.html { render :edit }
        format.json { render json: @community.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /communities/1
  # DELETE /communities/1.json
  def destroy
    @community.destroy
    respond_to do |format|
      format.html { redirect_to communities_url, notice: 'Community was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_community
      @community = Community.find(params[:id])
    end

    def ensure_user_can_edit_community
      unless @community.owner == current_user
        redirect_to community_home_path, notice: "Only Administrator can make this edit."
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def community_params
      params.require(:community).permit(:name,
                                        :subdomain,
                                        :owner_id,
                                        :photo,
                                        :remote_photo_url,
                                        :is_active,
                                        { :user_ids => [] },
                                        digital_addresses_attributes: [:id, :name, :address_type, :url],
                                        address_attributes: [:id, :street_line_1, :street_line_2, :city, :state, :zip])
    end
end
