require 'rails_helper'

RSpec.describe "UsersSignups", type: :request do
  describe "GET /users_signups" do
    before(:each) do 
      @user = User.new(name: "Example User", email: "user@example.com",
        password: 'hellos', password_confirmation: 'hellos')
    end

    it "works! (now write some real specs)" do
      get signup_path
      expect(response).to have_http_status(200)
    end

    it "invalid signup information" do
      get signup_path
      assert_no_difference 'User.count' do
        post users_path, params: { user: { name:  "",
                                           email: "user@invalid",
                                           password:              "foo",
                                           password_confirmation: "bar" } }
      end
      assert_response :unprocessable_entity
      assert_template 'users/new'
    end

     it "valid signup information" do
      assert_difference 'User.count', 1 do
        post users_path, params: { user: { name:  "Example User",
                                           email: "user@example.com",
                                           password:              "password",
                                           password_confirmation: "password" } }
      end
      follow_redirect!
      assert_template 'users/show'
      expect(is_logged_in?).to be true
    end

    it "login with valid email/invalid password" do
      get login_path
      assert_template 'sessions/new'
      post login_path, params: { session: { email: 'will@will.com',
                                            password: "invalid" } }
      assert_response :unprocessable_entity
      assert_template 'sessions/new'
      expect(flash.empty?).to be false
      get root_path
      expect(flash.empty?).to be true
    end
  end
end
