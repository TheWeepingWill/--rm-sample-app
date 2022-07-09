require 'rails_helpers'

RSpec.describe 'Sign In', type: :system do 
  let(:user) { User.create(name: 'Will', email: 'will@something.com', password: 'hellos') }
end