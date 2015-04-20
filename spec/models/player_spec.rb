require 'spec_helper'

describe Player do
  context "" do

    it 'should return a list of undrafted players' do
      Team.create(tname: 'Packers', division: 'NFC')
      Player.create(pname: 'John Smith', position: 'QB')
      Player.create(pname: 'Joe Montana', position: 'QB')
      Player.create(pname: 'Drew Bledsoe', position: 'QB')
      Player.create(pname: 'Dion Sanders', position: 'QB')
      Pick.create(round: 1, pick:1)
      expect(Player.undrafted.to_a.size).to eq 4
    end

    it 'should validate presence of pname' do
      should validate_presence_of(:pname)
    end
    it 'should validate presence of position' do
      should validate_presence_of(:position)
    end

  end
end
