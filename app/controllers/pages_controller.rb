class PagesController < ApplicationController
  def index
    render layout: "v3"
  end

  def enroll

    @default_period = Setting.default_period
    @default_role   = Setting.default_role
    @current_tshirt = Setting.current_tshirt

    if request.post?
      @membership = Membership.new(membership_params)
      @membership.user = current_user

      if @membership.save
        msg = "OK"
      else
        msg = "nie OK"
      end
    end

    render layout: "v3"
  end

  def members_admin
    render layout: "v3"
  end

  def tshirts_admin
    render layout: "v3"
  end

  def definitions
    render layout: "v3"
  end

  def unused
  end

  def advanced
  end

  def configure
    @periods = Period.all
    @roles   = Role.all
    @tshirts = TshirtDefinition.all
    @default_period = Setting.default_period
    @default_role   = Setting.default_role
    @current_tshirt = Setting.current_tshirt

    if request.post?
      Setting.default_period = params[:default_period]
      Setting.default_role   = params[:default_role]
      Setting.current_tshirt = params[:current_tshirt]

      @default_period = Setting.default_period
      @default_role   = Setting.default_role
      @current_tshirt = Setting.current_tshirt
    end



    render layout: "v3"
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:fee_paid, :tshirt, :member_id, { role_ids: [] }, :period_id, comment_attributes: :text, member_attributes: [:name, :surname, :email, :card_id])
    end
end
