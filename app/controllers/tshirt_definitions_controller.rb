class TshirtDefinitionsController < ApplicationController
  before_action :set_tshirt_definition, only: [:show, :edit, :update, :destroy]

  # GET /tshirt_definitions
  # GET /tshirt_definitions.json
  def index
    @tshirt_definitions = TshirtDefinition.all
  end

  # GET /tshirt_definitions/1
  # GET /tshirt_definitions/1.json
  def show
  end

  # GET /tshirt_definitions/new
  def new
    @tshirt_definition = TshirtDefinition.new
  end

  # GET /tshirt_definitions/1/edit
  def edit
  end

  # POST /tshirt_definitions
  # POST /tshirt_definitions.json
  def create
    @tshirt_definition = TshirtDefinition.new(tshirt_definition_params)

    respond_to do |format|
      if @tshirt_definition.save
        format.html { redirect_to @tshirt_definition, notice: 'Definicja koszulki pomyślnie dodana' }
        format.json { render :show, status: :created, location: @tshirt_definition }
      else
        format.html { render :new }
        format.json { render json: @tshirt_definition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tshirt_definitions/1
  # PATCH/PUT /tshirt_definitions/1.json
  def update
    respond_to do |format|
      if @tshirt_definition.update(tshirt_definition_params)
        format.html { redirect_to @tshirt_definition, notice: 'Definicja koszulki pomyślnie zmieniona' }
        format.json { render :show, status: :ok, location: @tshirt_definition }
      else
        format.html { render :edit }
        format.json { render json: @tshirt_definition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tshirt_definitions/1
  # DELETE /tshirt_definitions/1.json
  def destroy
    # TODO: same as with membership period definition: do not allow to break DB
    @tshirt_definition.destroy
    respond_to do |format|
      format.html { redirect_to tshirt_definitions_url, notice: 'Definicja koszulki pomyślnie zniszcznona' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tshirt_definition
      @tshirt_definition = TshirtDefinition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tshirt_definition_params
      params.require(:tshirt_definition).permit(:name, :produced, :comments, :image)
    end
end
