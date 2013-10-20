class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :mailer_set_host_url

  private

  def current_organization
    @current_organization ||= Organization.find(session[:organization_id]) if session[:organization_id]
  end

  def logged_in
    !current_organization.nil?
  end

  helper_method :logged_in
  helper_method :current_organization

  def authorize(org_id)
    if !logged_in
      redirect_to login_path, alert:"Not Authorized- Please Login."
    elsif current_organization.id != org_id
      redirect_to root_path, alert:"Action Not Authorized"
    end
  end

    def authorize
      redirect_to login_path, alert:"Not Authorized- Please Login." unless logged_in
    end


  def mailer_set_host_url
    ActionMailer::Base.default_url_options = {:host => request.host_with_port}
  end

end