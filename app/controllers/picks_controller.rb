class PicksController < ApplicationController
  layout 'admin', :only => [:admin]

  def index
    @pick      = Pick.active_pick
    @on_deck   = Pick.on_deck
    @previous  = Pick.previous
    @teams     = Team.all.to_a
    @remainder = Player.undrafted
    respond_to do |format|
      format.html
      format.js { render :partial => 'shared/realtime', :locals => {:pick => @pick, :on_deck => @on_deck, :previous => @previous} }
      format.json { render json: [@pick, @on_deck, @previous], include: [:team, :player] }
    end
  end

  def admin
    @admin = true
    self.index
  end

  def by_round
    r = params[:round]
    @picks = Pick.by_round(r)
    respond_to do |format|
      format.html
      format.json { render json: @picks, include: [:team, :player] }
    end
  end
end
