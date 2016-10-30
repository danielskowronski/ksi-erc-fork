class TshirtIssuesController < ApplicationController
  before_action :set_tshirt_issue, only: [:show, :edit, :update, :destroy]

  # GET /tshirt_issues
  # GET /tshirt_issues.json
  def index
    @tshirt_issues = TshirtIssue.all
  end

  # GET /tshirt_issues/1
  # GET /tshirt_issues/1.json
  def show
  end

  # GET /tshirt_issues/new
  def new
    @tshirt_issue = TshirtIssue.new
  end

  # GET /tshirt_issues/1/edit
  def edit
  end

  # POST /tshirt_issues
  # POST /tshirt_issues.json
  def create
    @tshirt_issue = TshirtIssue.new(tshirt_issue_params)

    respond_to do |format|
      if @tshirt_issue.save
        format.html { redirect_to @tshirt_issue, notice: 'Koszulka pomyślnie wydana członkowi' }
        format.json { render :show, status: :created, location: @tshirt_issue }
      else
        format.html { render :new }
        format.json { render json: @tshirt_issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tshirt_issues/1
  # PATCH/PUT /tshirt_issues/1.json
  def update
    respond_to do |format|
      if @tshirt_issue.update(tshirt_issue_params)
        format.html { redirect_to @tshirt_issue, notice: 'Poprawiono rekord wydania koszulki członkowi' }
        format.json { render :show, status: :ok, location: @tshirt_issue }
      else
        format.html { render :edit }
        format.json { render json: @tshirt_issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tshirt_issues/1
  # DELETE /tshirt_issues/1.json
  def destroy
    @tshirt_issue.destroy
    respond_to do |format|
      format.html { redirect_to tshirt_issues_url, notice: 'Anulowano wydanie koczulki członkowi' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tshirt_issue
      @tshirt_issue = TshirtIssue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tshirt_issue_params
      params.require(:tshirt_issue).permit(:comment, :member_id, :tshirt_definition_id)
    end
end
