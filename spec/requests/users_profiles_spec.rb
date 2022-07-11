require 'rails_helper'

RSpec.describe "UsersProfiles", type: :request do
  include ApplicationHelper


  before(:each) do 
    @user = User.create(name: "Example User", email: "user@example.com",
      password: 'hellos', password_confirmation: 'hellos')
  end

  
  describe "GET /users_profiles" do
    it "works! (now write some real specs)" do
      get users_profiles_path
      expect(response).to have_http_status(200)
    end
  end
end
