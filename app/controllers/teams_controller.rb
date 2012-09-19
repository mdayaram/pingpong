class TeamsController < ApplicationController
  before_filter :authenticate_admin!, :only => [:new, :create, :destroy] 
  # GET /teams
  # GET /teams.json
  def index
    @serious = Team.where(:league => "serious").order("LOWER(name)")
    @fun = Team.where(:league => "fun").order("LOWER(name)")
    @doubles = Team.where(:league => "doubles").order("LOWER(name)")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: [@serious, @fun, @doules] }
    end
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @team = Team.find(params[:id])
    @team.emails.gsub!(/((^| ).*?)@(.*?)\.(.*?(,|$))/, '\1 at \3 dot \4')
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @team }
    end
  end

  # GET /teams/new
  # GET /teams/new.json
  def new
    @team = Team.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @team }
    end
  end

  # GET /teams/1/edit
  def edit
    @team = Team.find(params[:id])
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(params[:team])

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render json: @team, status: :created, location: @team }
      else
        format.html { render action: "new" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /teams/1
  # PUT /teams/1.json
  def update
    @team = Team.find(params[:id])
    # Don't allow update of members or league.

    if !admin_signed_in?
      params[:team].delete(:members)
      params[:team].delete(:emails)
      params[:team].delete(:league)
    end

    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :no_content }
    end
  end
end
