class PasswordResetsController < ApplicationController
  def new
  end

  def create
    organization = Organization.find_by_email(params[:email])
    organization.send_password_reset if organization
    redirect_to root_url, :notice => "Email sent with password reset instructions."
  end

  def edit
    @organization = Organization.find_by_password_reset_token!(params[:id])
  end

def update
  @organization = Organization.find_by_password_reset_token!(params[:id])
  if @organization.password_reset_sent_at < 10.hours.ago
    redirect_to new_password_reset_path, :alert => "Password reset has expired."
  elsif @organization.update_attributes( params[:organization])
    session[:organization_id] = @organization.id
    redirect_to root_url, :notice => "Password has been reset! Welcome Back! :)"
  else
    render :edit
  end
end

end
