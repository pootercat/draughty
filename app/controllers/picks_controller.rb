class PicksController < ApplicationController
  layout 'admin', :only => [:admin]

  def index
    self.dashboard
  end

  def dashboard
    @draft_open   = true #TODO make this a real switch
    @picking_now  = self.picking
    @picking_next = self.picking_next
    @recent_picks = self.recent
    @teams        = Team.all.to_a
    @draftables   = Player.undrafted
    @positions    = Player.positions.sort
    respond_to do |format|
      format.html
      format.json { render json: [@recent_picks, @picking_now, @picking_next], include: [:team, :player]}
    end
  end

  def admin
    @draft_open   = true #TODO make this a real switch
    @draftables   = Player.undrafted
    @admin = true
    self.dashboard
  end

  def by_round
    r = params[:round]
    @picks = Pick.by_round(r)
    respond_to do |format|
      format.html
      format.json { render json: @picks, include: [:team, :player] }
    end
  end

  def picking
    Pick.active_pick
  end

  def picking_next
    Pick.on_deck
  end

  def by_team
  end

  def recent
    Pick.previous
  end
end
