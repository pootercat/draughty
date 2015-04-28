class PicksController < ApplicationController
  layout 'admin', :only => [:admin]

  def index
    self.dashboard
  end

  def dashboard
    @draft_status = draft_status
    @picking_now  = self.picking
    @picking_next = self.picking_next
    @recent_picks = self.recent
    @teams        = Team.all.to_a
    @draftables   = Player.undrafted
    @positions    = Player.positions.sort
    #only retrieve final pick data if draft is done
    @final_picks  = Pick.completed if @draft_status == 'completed'
    respond_to do |format|
      format.html
      format.json { render json: [@recent_picks, @picking_now, @picking_next], include: [:team, :player]}
    end
  end

  def admin
    @draft_status = draft_status
    @draftables   = Player.undrafted
    #only retrieve final pick data if draft is done
    @final_picks  = Pick.completed if @draft_status == 'completed'
    @admin = true
    self.dashboard
  end

  def by_round
    r = params[:round]
    @picks = Pick.by_round(r)
    respond_to do |format|
      format.html { render json: @picks, include: [:team, :player] }
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

  private
  def draft_status
    has_picks = Pick.all.size > 0
    has_pending = Pick.pending.size > 0
    (has_picks && !has_pending) ? 'completed' : has_pending ? 'open' : 'empty'
  end
end
