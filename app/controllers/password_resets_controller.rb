class PasswordResetsController < ApplicationController


  def new
  end

  def index
    redirect_to new_password_reset_url
  end

  def create
    organization = Organization.find_by_email(params[:email])
    if organization
      organization.send_password_reset if organization
      redirect_to root_url, :notice => "Email sent with password reset instructions."
    else
      flash.now.alert = "No account for email address."
      render :new
    end
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
    redirect_to teams_url, :notice => "Password has been reset! Welcome Back! :)"
  else
    render :edit
  end
end

end
