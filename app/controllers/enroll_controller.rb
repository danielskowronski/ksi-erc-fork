class EnrollController < ApplicationController
  layout "v3"

  def index
  end

  def enroll
    @default_period = Setting.default_period
    @default_role   = Setting.default_role
    @current_tshirt = Setting.current_tshirt

    #for auto completing form with errors
    @membership = Membership.new
    @membership.member = Member.new

    if request.post?
      @membership = Membership.new(membership_params)
      @membership.user = current_user
      @success = @membership.save
      errors = @membership.errors
      @message = ""
      errors.full_messages.each do |msg|
        @message+="<li>"+msg+"</li>"
      end
      debugger
    end

  end

  def fee
  end

  def tshirt
  end

  def lock
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
