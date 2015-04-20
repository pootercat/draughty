class Player < ActiveRecord::Base
  has_one :pick
  has_one :team, through: :pick

  validates :pname, presence: true
  validates :position, presence: true

  def self.undrafted
    Player.includes(:pick).where(:picks => {:player_id => nil}).order(position: :asc, pname: :asc)
  end

  def self.available_by_position(p)
    p.blank? ? [] : Player.undrafted.where(position: p)
  end

  def self.positions
    Player.select(:position).uniq.map { |row| row.position }
  end
end
