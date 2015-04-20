require 'spec_helper'

describe Player do
  context "" do

    it 'should return a list of undrafted players' do
      Team.create(tname: 'Packers', division: 'NFC')
      Player.create(pname: 'John Smith', position: 'QB')
      Player.create(pname: 'Joe Montana', position: 'QB')
      Player.create(pname: 'Drew Bledsoe', position: 'QB')
      Player.create(pname: 'Dion Sanders', position: 'QB')
      Pick.create(round: 1, pick:1, team_id: Team.first['id'])
      expect(Player.undrafted.to_a.size).to eq 4
    end

    it 'should return unique list of positions' do
      Player.create(pname: 'John Smith', position: 'QB')
      Player.create(pname: 'Joe Montana', position: 'RB')
      Player.create(pname: 'Drew Bledsoe', position: 'WR')
      Player.create(pname: 'Dion Sanders', position: 'P')
      expect(Player.positions.sort.first).to eq 'P'
      expect(Player.positions.last).to eq 'P'
      expect(Player.positions.size).to eq 4
      Player.delete_all
    end

    it 'should return list of players available by position' do
      Team.create(tname: 'Packers', division: 'NFC')
      Player.create(pname: 'John Smith', position: 'QB')
      Player.create(pname: 'Joe Montana', position: 'RB')
      Player.create(pname: 'Drew Bledsoe', position: 'WR')
      Player.create(pname: 'Dion Sanders', position: 'P')
      Pick.create(round: 1, pick:1, team_id: Team.first['id'])
      before_draft = Player.available_by_position('QB').to_a
      Team.draft_player(Player.first['id'])
      after_draft = Player.available_by_position('QB').to_a
      expect(before_draft.size).to be > after_draft.size
    end

    it 'should validate presence of pname' do
      should validate_presence_of(:pname)
    end
    it 'should validate presence of position' do
      should validate_presence_of(:position)
    end

  end
end
