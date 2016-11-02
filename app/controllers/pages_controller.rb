class PagesController < ApplicationController
  def index
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
    @lock_allowed   = Setting.lock_allowed

    if request.post?
      Setting.default_period = params[:default_period]
      Setting.default_role   = params[:default_role]
      Setting.current_tshirt = params[:current_tshirt]
      Setting.lock_allowed   = params[:lock_allowed]

      @default_period = Setting.default_period
      @default_role   = Setting.default_role
      @current_tshirt = Setting.current_tshirt
      @lock_allowed   = Setting.lock_allowed
    end

    render layout: "v3"
  end

end
