require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/sessions/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'flash persistence' do 
    it 'flash does not persist over mutltiple requests' do 
      get login_path
      assert_template 'sessions/new'
      post login_path, params: { session: { email: "", password: "" } }
      assert_response :unprocessable_entity
      assert_template 'sessions/new'
      expect(flash.empty?).to be false
      get root_path
      expect(flash.empty?).to be true
    end
  end

end
