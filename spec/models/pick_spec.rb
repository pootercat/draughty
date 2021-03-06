require 'spec_helper'

describe Pick do
  before :example do
    create(:team)
    create(:player)
  end

  context "" do
    it 'should return a list of completed picks' do
      Pick.create(round: 1, pick:1)
      Team.draft_player(Player.first['id'])
      expect(Pick.completed.to_a.size).to eq 1
    end

    it 'should return a list of pending picks' do
      create(:pick)
      Pick.create(round: 1, pick:2)
      Pick.create(round: 1, pick:3)
      Pick.create(round: 1, pick:4)
      expect(Pick.pending.to_a.size).to eq 4
    end

    it "should return a list of picks by round" do
      create(:pick)
      Team.draft_player(Player.first['id'])
      expect(Pick.by_round(1).to_a.size).to eq 1
    end

    it "should return a list of picks by team" do
      Team.create(tname: 'Giants', division: 'AFC')
      Pick.create(round: 1, pick:1, team_id: Team.first['id'])
      Pick.create(round: 1, pick:2, team_id: Team.last['id'])
      Team.draft_player(Player.first['id'])
      expect(Pick.by_team('Browns').to_a.size).to eq 1
    end

    it "should return the team that is currently picking" do
      Team.create(tname: 'Giants', division: 'AFC')
      Pick.create(round: 1, pick:1, team_id: Team.first['id'])
      Pick.create(round: 1, pick:2, team_id: Team.last['id'])
      expect(Pick.active_pick).to be_truthy
    end

    it "should return the team that will be picking next" do
      Team.create(tname: 'Giants', division: 'AFC')
      Pick.create(round: 1, pick:1, team_id: Team.first['id'])
      Pick.create(round: 1, pick:2, team_id: Team.last['id'])
      expect(Pick.on_deck).to be_truthy
    end

    it 'should validate presence of round' do
      should validate_presence_of(:round)
    end
    it 'should validate presence of pick' do
      should validate_presence_of(:pick)
    end
    it 'should validate uniqueness of pick' do
      should validate_uniqueness_of(:pick)
    end

  end

end
