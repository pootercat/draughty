class Player < ActiveRecord::Base
  has_one :pick
  has_one :team, through: :pick

  validates :pname, presence: true
  validates :position, presence: true

  def self.undrafted
    Player.includes(:pick).where(:picks => {:player_id => nil}).order(position: :asc, pname: :asc)
  end
end
