require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do 
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: 'hellos', password_confirmation: 'hellos')
  end

  describe 'validation' do 
    it 'is valid with given values' do 
      expect(@user.valid?).to be true
    end

    it 'is not valid with an empty name' do
      @user.name = '     ' 
      expect(@user.valid?).to be false
    end

    it 'is not valid with an empty email' do
      @user.email = '     ' 
      expect(@user.valid?).to be false
    end

    it 'is not valid if email too long' do
      @user.email = 'b' * 256 
      expect(@user.valid?).to be false
    end


    it 'is not valid if name too long' do
      @user.name = 'a' * 51 
      expect(@user.valid?).to be false
    end

    it 'validates valid emails' do 
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
        first.last@foo.jp alice+bob@baz.cn]

      valid_addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user.valid?).to be true
        puts  "#{valid_address.inspect} should be valid"
      end
    end

    it 'does not validate invalid emails' do 
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
        foo@bar_baz.com foo@bar+baz.com foo@bar..com ]

      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user.valid?).to be false
        puts  "#{invalid_address.inspect} should be invalid"
      end
    end

    it 'does not validate a duplicate email' do 
      duplicate_user = @user.dup
      @user.save
      expect(duplicate_user.valid?).to be false
    end

    it 'downcases before storing in the database' do 
      mixed_case_email = 'WIlliAm@GmAIl.cOm'
      @user.email = mixed_case_email
      @user.save
      expect(@user.email.downcase).to eq @user.reload.email
    end

    it 'password should be present' do 
      @user.password = " " * 6
      expect(@user.valid?).to be false
    end

    it 'minimum password length of 6' do 
      @user.password = "a" * 5
      expect(@user.valid?).to be false
    end
  end
end
