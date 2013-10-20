class OrganizationsController < ApplicationController

  before_filter :set_organization, only: [:edit,:update, :destroy]
  before_filter only: [:edit,:update, :destroy] do |c| c.send(:authorize, params[:id])   end


  # GET /organizations/new
  def new
    redirect_to root_url unless current_organization.nil?
    @organization = Organization.new
  end

  # GET /organizations/1/edit
  def edit
    
  end

  # GET /
  def home
    if logged_in
      redirect_to people_path
    else
      render action: "landing"
    end
  end

  def dashboard
  end

  def landing
  end

  # POST /organizations
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
  def update
    @organization = Organization.find(params[:id])

      if @organization.update_attributes(params[:organization])
        redirect_to @organization, notice: 'Organization was successfully updated.'
      else
        render action: "edit"
      end
  end

  # DELETE /organizations/1
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
