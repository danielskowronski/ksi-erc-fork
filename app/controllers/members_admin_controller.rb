class MembersAdminController < ApplicationController
  layout "v3"

  def index
  end

  def mailing
    @members = Member.all
    @lista = ""
    @members.each do |member|
      @lista += member.full_name(old_style: true) + " <" + member.email + ">, "
    end
    @lista = @lista[0..-3]
  end

  def current
    @current_year = Setting.lock_allowed
    @memberships = Membership.joins(:period).where(periods: {academic_year: Setting.lock_allowed})
  end

  def all
    @current_year = Setting.lock_allowed
    @members = Member.joins(:periods).group(:id)
  end

  def show
    @id = request.path_parameters[:id]
    @member = Member.find(@id)
    require 'digest/md5'
    email_address = @member.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    @picture = "https://www.gravatar.com/avatar/#{hash}"
    @member_periods = Membership.where(member_id: @id)
    @member_tshirts = TshirtIssue.where(member_id: @id)
  end
end
