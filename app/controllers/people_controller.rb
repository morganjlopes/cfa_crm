class PeopleController < ApplicationController
  before_action :authenticate_user!
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  # GET /people
  # GET /people.json
  def index
    @people = Person.all
    @tab_name = "people"
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @noteable   = @person
    @note       = @person.notes.new
    @notes      = @person.notes.order("created_at desc")

    @tab_name = "people"
  end

  # GET /people/new
  def new
    @person = Person.new
    @person.digital_addresses.build
    @person.employments.build
    @tab_name = "people"
  end

  # GET /people/1/edit
  def edit
    @tab_name = "people"
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)

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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:name,
                                     :bio,
                                     :gender,
                                     :photo,
                                     :slug,
                                     digital_addresses_attributes: [:id, :name, :address_type, :url],)
    end
end
