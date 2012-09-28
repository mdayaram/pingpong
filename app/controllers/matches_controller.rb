class MatchesController < ApplicationController
  before_filter :authenticate_admin!, :only => [:new, :edit, :create, :update, :destroy] 

### Helpers
  def get_bracket(bracket_name)
    ms = Match.where(:bracket => [bracket_name, "#{bracket_name}_wildcard", "#{bracket_name}_finals"])
    @matches = Hash.new
    ms.each do |m|
       @matches[m.round] = m
    end

    respond_to do |format|
      format.html
      format.json { render json: @matches }
    end
  end

### Public to all pages.
  def index
    @matches = Match.all

    respond_to do |format|
      format.html
      format.json { render json: @matches }
    end
  end

  def all
    respond_to do |format|
    format.html
  end

  def serious
    get_bracket("serious")
  end
  def serious_wildcard
    get_bracket("serious_wildcard")
  end
  def fun
    get_bracket("fun")
  end
  def fun_wildcard
    get_bracket("fun_wildcard")
  end
  def doubles
    get_bracket("doubles")
  end
  def doubles_wildcard
    get_bracket("doubles_wildcard")
  end


  # GET /matches/1
  # GET /matches/1.json
  def show
    @match = Match.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @match }
    end
  end
 
  def set_schedule
    @match = Match.find(params[:id])
		if @match.blank?
			raise "Invalid match id."
		end

		if params[:schedule].blank?
			raise "Invalid time selected for match's schedule."
		end
		
    respond_to do |format|
      if @match.update_attributes(:schedule => params[:schedule])
        format.html { redirect_to @match, notice: 'Match schedule successfully update.' }
        format.json { render json: @match, status: :created, location: @match }
      else
        format.html { redirect_to @match, error: "Failed to set match to scheduled time." }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  def declare_win
    @match = Match.find(params[:id])
    if @match.blank?
      raise "Invalid match id."
    end

    @winner = Team.find(params[:winner])
    if @winner.blank?
      raise "Couldn't find a Team with #{params[:winner]} id"
    end

    @loser = @match.get_other_team(@winner)
    
    # 1) Set the winner in the winner field
    # 2) If schedule is not set, set it to now
    # 3) Find the next matches for both teams and update those as well.
    @match.win_team = @winner
    if @match.schedule.blank?
      @match.schedule = DateTime.now
    end
    
    if !@match.save
      raise "Failed to update match."
    end

    if @match.next_winner_match.blank?
      puts "Damn son, winner match be blank."
    end

    if @match.next_loser_match.blank?
      puts "Damn it again son, loser match be blank too."
    end

    if !@match.next_winner_match.blank? && !@match.next_winner_match.set_team(@winner).save
      raise "Failed to update the leading winning match."
    end
    if !@match.next_loser_match.blank? && !@match.next_loser_match.set_team(@loser).save
      raise "Failed to update the leading loser match."
    end

    respond_to do |format|
      format.html { redirect_to @match, notice: "Winner declared! Congratulations, #{@winner.name}!" }
      format.json { head :no_content }
    end
  end


###  Admin only features.
  # GET /matches/new
  # GET /matches/new.json
  def new
    @match = Match.new
    @teams = Team.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @match }
    end
  end

  # GET /matches/1/edit
  def edit
    @teams = Team.all
    @match = Match.find(params[:id])
  end

  # POST /matches
  # POST /matches.json
  def create
    @match = Match.new(params[:match])

    respond_to do |format|
      if @match.save
        format.html { redirect_to @match, notice: 'Match was successfully created.' }
        format.json { render json: @match, status: :created, location: @match }
      else
        format.html { render action: "new" }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /matches/1
  # PUT /matches/1.json
  def update
    @match = Match.find(params[:id])

    respond_to do |format|
      if @match.update_attributes(params[:match])
        format.html { redirect_to @match, notice: 'Match was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matches/1
  # DELETE /matches/1.json
  def destroy
    @match = Match.find(params[:id])
    @match.destroy

    respond_to do |format|
      format.html { redirect_to matches_url }
      format.json { head :no_content }
    end
  end
end
