class PagesController < ApplicationController
  def index
    render layout: "v3"
  end

  def members_admin

    render layout: "v3"
  end

  def members_admin_show
    @id = request.path_parameters[:id]
    @member = Member.find(@id)
    require 'digest/md5'
    email_address = @member.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    @picture = "https://www.gravatar.com/avatar/#{hash}"
    @member_periods = Membership.where(member_id: @id)
    @member_tshirts = TshirtIssue.where(member_id: @id)

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

end
