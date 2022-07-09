require 'rails_helper'
require 'pry'

RSpec.describe "UsersLogins", type: :request do
  describe "GET /users_logins" do

    before(:each) do 
      @user = User.create(name: "Example User", email: "user@example.com",
        password: 'hellos', password_confirmation: 'hellos')
    end

    it "works! (now write some real specs)" do
      get login_path
      expect(response).to have_http_status(200)
    end

    it "login with invalid information" do
      get login_path
      assert_template 'sessions/new'
      expect(is_logged_in?).to be false
      post login_path, params: { session: { email: "", password: "" } }
      assert_response :unprocessable_entity
      assert_template 'sessions/new'
      expect(flash.empty?).to be false
      get root_path
      expect(flash.empty?).to be true
    end

    it "login with valid email/invalid password" do
      get login_path
      assert_template 'sessions/new'
      post login_path, params: { session: { email:    @user.email,
                                            password: "invalid" } }
      assert_not is_logged_in?
      assert_response :unprocessable_entity
      assert_template 'sessions/new'
      expect(flash.empty?).to be false
      get root_path
      expect(flash.empty?).to be true
    end

    # it "login with valid information followed by logout" do
    #   post login_path, params: { session: { :email => @user.email,
    #                                         password: 'hellos' } }
    #   expect(is_logged_in?).to be true
    #   assert_redirected_to @user
    #   follow_redirect!
    #   assert_template 'users/show'
    #   expect(response).to "a[href=?]", login_path, count: 0
    #   assert_select "a[href=?]", logout_path
    #   assert_select "a[href=?]", user_path(@user)
    #   delete logout_path
    #   assert_not is_logged_in?
    #   assert_response :see_other
    #   assert_redirected_to root_url
    #   follow_redirect!
    #   assert_select "a[href=?]", login_path
    #   assert_select "a[href=?]", logout_path,      count: 0
    #   assert_select "a[href=?]", user_path(@user), count: 0
    # end
  end
end
