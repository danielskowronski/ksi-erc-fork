class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login

  def not_authenticated
    flash[:alert] = "Musisz być zalogowany, żeby zobaczyć tą stronę!"
    redirect_to login_path
  end
end
