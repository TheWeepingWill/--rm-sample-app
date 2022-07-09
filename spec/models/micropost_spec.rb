require 'rails_helper'

RSpec.describe Micropost, type: :model do

  before(:each) do 
    @user = User.new(name: "Example User", email: "user@example.com",
                      password: 'hellos', password_confirmation: 'hellos')
    @micropost = Micropost.new(content: "Lorem ipsum", user_id: @user.id)
  end
  
  spec 'should be valid' do 
    asser @micropost.valid?
  end

  test "user id should be present" do
    @micropost.user_id = nil
    expect(@micropost.valid?).to be false 
  end

end
