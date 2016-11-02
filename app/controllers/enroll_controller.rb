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

      if @success
        redirect_to new_members_show_url(@membership.member.id), :flash => { :success => "Pomyślnie zapisano do koła" }
      end
    end
  end

  def fee
    @default_period = Setting.default_period

    if request.post?
      membership_id = params[:membership][:id]
      @success2 = Membership.update(membership_id, :fee_paid=> true)
      errors = @success2.errors
      errors.full_messages.each do |msg|
        @message+="<li>"+msg+"</li>"
      end
      @success = @success2.errors.messages.empty?

      if @success
        redirect_to new_members_show_url(@success2.member.id), :flash => { :success => "Pomyślnie przyjęto składkę" }
      end
    end
  end

  def tshirt
  end

  def lock
    File.open('tmp/last_card_id.txt', 'r') do |f|
      @last_card_id = f.gets.strip
    end

    @count = Member.where(:card_id=>@last_card_id).count
    if @count>0
      @card_err=true
    else
      @card_err=false
    end

    if request.post?
      member_id = params[:member][:id]
      @success = Member.update(member_id, :card_id=> params[:member][:card_id])
      errors = @success.errors
      @message = ""
      errors.full_messages.each do |msg|
        @message+="<li>"+msg+"</li>"
      end
      @success = @success.errors.messages.empty?

      if @success
        redirect_to new_members_show_url(member_id), :flash => { :success => "Pomyślnie dodano do zamka elektronicznego"}
      end
    end
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