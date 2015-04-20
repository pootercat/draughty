require 'rails_helper'

RSpec.describe PicksController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to be_success
    end
  end

  describe "GET admin" do
    it "returns http success" do
      get :admin
      expect(response).to be_success
    end
  end

  describe "GET by_round" do
    it "returns http success" do
      get :by_round
      expect(response).to be_success
    end
  end

end
