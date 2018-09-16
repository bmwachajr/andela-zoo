require 'httparty'

class AnimalsController < ApplicationController
  before_action :set_animal, only: [:show, :edit, :update, :destroy]

  # GET /animals
  # GET /animals.json
  def index
    @animals = Animal.all
  end

  # GET /animals/1
  # GET /animals/1.json
  def show
    # puts params
    @suspensions = legislation(params[:id])
  end

  # GET /animals/new
  def new
    @animal = Animal.new
  end

  # GET /animals/1/edit
  def edit
  end

  # POST /animals
  # POST /animals.json
  def create
    @animal = Animal.new(animal_params)

    respond_to do |format|
      if @animal.save
        format.html { redirect_to @animal, notice: 'Animal was successfully created.' }
        format.json { render :show, status: :created, location: @animal }
      else
        format.html { render :new }
        format.json { render json: @animal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /animals/1
  # PATCH/PUT /animals/1.json
  def update
    respond_to do |format|
      if @animal.update(animal_params)
        format.html { redirect_to @animal, notice: 'Animal was successfully updated.' }
        format.json { render :show, status: :ok, location: @animal }
      else
        format.html { render :edit }
        format.json { render json: @animal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /animals/1
  # DELETE /animals/1.json
  def destroy
    @animal.destroy
    respond_to do |format|
      format.html { redirect_to animals_url, notice: 'Animal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def taxonomy
    url = 'https://api.speciesplus.net/api/v1/taxon_concepts'
    headers = {
      "X-Authentication-Token": 'Rk7DfB3l25nsX6zV4qozTQtt'
    }

    response = HTTParty.get(url, headers: headers)

    for taxonomy in response["taxon_concepts"]
      @animal = Animal.new(animal_fixture(taxonomy))
      @animal.save!
    end
    
    redirect_to :index
  end

  def legislation(cites_id)
    taxonimic_id = cites_id
    url = "https://api.speciesplus.net/api/v1/taxon_concepts/#{taxonimic_id}/cites_legislation"
    headers = {
      "X-Authentication-Token": 'Rk7DfB3l25nsX6zV4qozTQtt'
    }

    response = HTTParty.get(url, headers: headers)

    suspensions = []

    for suspension in response["cites_suspensions"]
      suspensions << {
        notes: suspension["notes"],
        country: suspension["geo_entity"]["name"],
        cite: suspension["start_notification"]["name"],
        date: suspension["start_notification"]["date"],
        url: suspension["start_notification"]["url"]
      }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_animal
      @animal = Animal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def animal_params
      params.require(:animal).permit(:cites_id, :common_name, :kingdom, :phylum, :animal_class, :order, :family)
    end

    def animal_fixture(data)
      common_name = ""
      # byebug
      for name in data["common_names"]
        common_name << name['name']
        common_name << ","
      end
      
      kingdom = data["higher_taxa"]["kingdom"] || ""
      phylum = data["higher_taxa"]["phylum"] || ""
      animal_class = data["higher_taxa"]["class"] || ""
      order = data["higher_taxa"]["order"] || ""
      family = data["higher_taxa"]["family"] || ""

      params = {cites_id: data["id"], common_name: common_name, kingdom: kingdom, phylum: phylum, animal_class: animal_class,  order: order, family: family}
    end
end
