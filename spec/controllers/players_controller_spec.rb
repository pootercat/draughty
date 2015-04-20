require 'rails_helper'

RSpec.describe PlayersController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to be_success
    end
  end

  describe "GET undrafted" do
    it "returns http success" do
      get :undrafted
      expect(response).to be_success
    end
  end

  describe "GET avail by position" do
    it "returns http success" do
      get :available_by_position
      expect(response).to be_success
    end
  end
end
