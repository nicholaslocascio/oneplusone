class OrganizationsController < ApplicationController

  before_filter :set_organization, only: [:edit,:update, :destroy] 
  before_filter only: [:edit,:update, :destroy] do |c| c.send(:authorize, params[:id])   end

  # GET /organizations/new
  # GET /organizations/new.json
  def new
    redirect_to root_url unless current_organization.nil?
    @organization = Organization.new
  end

  # GET /organizations/1/edit
  def edit
    
  end

  def home
    if logged_in
      render action: "dashboard"
    else
      render action: "landing"
    end
  end

  def dashboard
  end

  def landing
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(params[:organization])

      if @organization.save
        session[:organization_id] = @organization.id
        redirect_to root_path, notice: 'Organization ' + @organization.name.to_s + ' is now on 1+1!'
      else
        render action: "new"
      end
  end

  # PUT /organizations/1
  # PUT /organizations/1.json
  def update
    @organization = Organization.find(params[:id])

      if @organization.update_attributes(params[:organization])
        redirect_to @organization, notice: 'Organization was successfully updated.'
      else
        render action: "edit"
      end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy
    session[:organization_id] = nil
    redirect_to root_path, notice: "Organization Deleted."
  end

  def set_organization
    @organization = Organization.find(params[:id])
  end
end
