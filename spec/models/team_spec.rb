require 'spec_helper'

describe Team do
  context "" do

    it 'should find team by name or id' do
      Team.create(tname: 'Packers', division: 'NFC')
      Team.create(tname: 'Giants', division: 'AFC')
      Team.create(tname: 'Jets', division: 'NFC')
      Team.create(tname: 'Browns', division: 'AAA')
      Team.create(tname: 'Bengals', division: 'NFC')
      Player.create(pname: 'John Smith', position: 'QB')
      Pick.create(round: 1, pick:1)
      Team.draft_player(Player.first['id'])
      expect(Team.all.to_a.size).to eq 5
      expect(Team.find_by_name_or_id('Browns')['tname']).to eq 'Browns'
      expect(Team.find_by_name_or_id('Browns')['division']).to eq 'AAA'
    end

    it 'should draft player' do
      Team.create(tname: 'Browns', division: 'AAA')
      Player.create(pname: 'John Smith', position: 'QB')
      Pick.create(round: 1, pick:1, team_id: Team.first['id'])
      before_draft = Pick.completed.to_a.size
      Team.draft_player(Player.first['id'])
      after_draft = Pick.completed.to_a.size
      expect(before_draft).to be < after_draft
    end

    it 'should validate presence of division' do
      should validate_presence_of(:division)
    end
    it 'should validate presence of tname' do
      should validate_presence_of(:tname)
    end
    it 'should validate uniqueness of tname' do
      should validate_uniqueness_of(:tname)
    end

  end
end
