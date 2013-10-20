class TeamsController < ApplicationController

  before_filter :set_team, only: [:show,:edit,:update, :destroy]
  before_filter only: [:show, :edit, :update, :destroy] do |c| c.send(:authorize, params[:id])   end
  before_filter :authorize, only: [:index]

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

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  def create
    @team = Team.new(params[:team])
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
    @team.destroy
    redirect_to teams_url
  end
end
