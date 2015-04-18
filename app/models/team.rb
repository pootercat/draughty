class Team < ActiveRecord::Base
  has_many :picks
  has_many :players, through: :picks

  validates :tname, presence: true, uniqueness: true
  validates :division, presence: true

  def self.find_by_name_or_id(team)
    team.to_i > 0 ? Team.find_by_id(team) : Team.find_by_tname(team)
  end

  def self.draft_player(player)
    pid = player.to_i
    p = Player.find_by_id(pid)
    if p
      pick = Pick.active_pick
      team = pick.team_id
      pick.player_id = pid
      pick.save!
    else
      Exception
    end
  end
end
