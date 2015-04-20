require 'rails_helper'

RSpec.describe TeamsController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to be_success
    end
  end

  describe "GET picks" do
    it "returns http success" do
      get :picks
      expect(response).to be_success
    end
  end

  describe "GET draft_player" do
    it "returns http success" do
      get :draft_player
      expect(response).to be_success
    end
  end

end
