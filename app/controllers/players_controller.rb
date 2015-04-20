class PlayersController < ApplicationController
  def undrafted
    @players = Player.undrafted.to_a
    respond_to do |format|
      format.html { render json: @players }
      format.json { render json: @players }
    end
  end

  def available_by_position
    pos = params[:position]
    @players = Player.available_by_position(pos.upcase)
    respond_to do |format|
      format.html { render json: @players }
      format.json { render json: @players }
    end
  end
end
