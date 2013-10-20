class TeamsController < ApplicationController

  before_filter :set_team, only: [:show,:edit,:update, :destroy, :add_person, :remove_person]
  before_filter only: [:show, :edit, :update, :destroy, :add_person, :remove_person] do |c| c.send(:authorize, @team.organization_id)   end
  before_filter :authorize_logged_in, only: [:index]

  # GET /teams
  def index
    @teams = current_organization.teams.all
  end

  # GET /teams/1
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end


# GET /teams/1/add_person/:person_id
  def add_person
    @person = Person.find(params[:person_id])
    @team.add_person(@person)
  end

  def remove_person
    person = Person.find(params[:person_id])
    @deleted_id = person.id
    @team.remove_person(person)
  end

  # GET /teams/1/edit
  def edit
    @members = @team.people.all
    @people = current_organization.people.all
    @people = @people.reject{ |e| @members.include? e }
  end

  # POST /teams
  def create
    @team = Team.new(params[:team])
    current_organization.teams << @team
      if @team.save
        redirect_to @team, notice: 'Team was successfully created.'
      else
        render action: "new"
      end
  end

  # PUT /teams/1
  def update
    if @team.update_attributes(params[:team])
      redirect_to @team, notice: 'Team was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /teams/1
  def destroy
    message = teamName.to_s + " Team Deleted."
    @team.destroy
    redirect_to teams_url, notice: message
  end

  def set_team
    @team = Team.find(params[:id])
  end
end
