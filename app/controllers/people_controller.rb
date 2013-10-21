class PeopleController < ApplicationController

  before_filter :set_person, only: [:show,:edit,:update, :destroy]
  before_filter only: [:show, :edit, :update, :destroy] do |c| c.send(:authorize, @person.organization_id)   end
  before_filter :authorize_logged_in, only: [:index, :new]
  # GET /people
  # GET /people.json
  def index
    @people = current_organization.people.all
  end

  # GET /people/1
  # GET /people/1.json
  def show
  end

  # GET /people/new
  # GET /people/new.json
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
    @person = Person.find(params[:id])
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(params[:person])
    current_organization.people << @person
      if @person.save
        redirect_to @person, notice: @person.name.to_s + ' was successfully created.'
      else
        render action: "new"
      end
  end

  # PUT /people/1
  # PUT /people/1.json
  def update

      if @person.update_attributes(params[:person])
        redirect_to @person, notice: 'Person was successfully updated.'
      else
        render action: "edit"
      end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    redirect_to people_url
  end

  def set_person
    @person = Person.find(params[:id])
  end
  
end
