class TeamsController < ApplicationController
  def index
  end

  def picks
    t = params[:team]
    @picks = Pick.by_team(t)
    respond_to do |format|
      format.html
      format.json { render json: @picks }
    end
  end

  def draft_player
    p = params[:player]
    Team.draft_player(p)
    respond_to do |format|
      format.html
      format.json { render json: {} }
    end
  end
end