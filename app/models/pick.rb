class Pick < ActiveRecord::Base
  belongs_to :team
  belongs_to :player

  validates :round, presence: true
  validates :pick, presence: true, uniqueness: true

  scope :completed,  -> { where.not(:player_id => nil) }
  scope :pending,    -> { where(:player_id => nil) }
  scope :from_round, ->(r) { where("round = ?",r) }
  scope :from_team,  ->(t) { where("team_id = ?",t) }

  def self.by_team(team)
    t = Team.find_by_name_or_id(team)
    t ? Pick.from_team(t.id).completed : t
  end

  def self.by_round(round)
    Pick.from_round(round).completed.order(pick: :asc)
  end

  def self.previous(qty:3)
    Pick.completed.order(pick: :desc).limit(qty.to_i)
  end

  def self.active_pick
    Pick.pending.order(pick: :asc).first
  end

  def self.on_deck
    Pick.pending.order(pick: :asc).second
  end

  def to_h
    self.as_json
  end
end
