class SessionsController < ApplicationController

  # GET /sessions/new
  def new
      redirect_to root_url unless current_organization.nil?
  end

  def create
    organization = Organization.find_by_email(params[:email])
    if organization and organization.authenticate(params[:password])
      session[:organization_id] = organization.id
      redirect_to teams_url, notice: 'Welcome Back! :)'
    else
      flash.now.alert = "Email or password is Invalid"
      render 'new'
    end
  end

  def destroy
    session[:organization_id] = nil
    redirect_to root_url, notice:"Logged out"
  end

end