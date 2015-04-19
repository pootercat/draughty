class AutoDraft

  def draft
    until Pick.active_pick.nil? do
      auto_pick
    end
  end

  private
  def auto_pick
    undrafted     = eligible_players.to_a
    random_player = undrafted.sample
    Team.draft_player random_player['id']
    timeout = random_wait_time
    puts "waiting #{timeout} seconds until next pick"
    sleep timeout
  end

  def eligible_players
    Player.undrafted
  end

  def random_wait_time
    [1,5,10,15,30].sample
  end

end
