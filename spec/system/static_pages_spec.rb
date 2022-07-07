require 'spec_helper' 
require 'pry'

RSpec.describe 'Static Pages', type: :system do 

  describe '/' do
    it 'responds successfully' do
      visit root_path
      expect(page).to have_content('This is the home page')
      expect(page.title).to have_content('Ruby on Rails Tutorial Sample App')
    end
  end

  describe 'home' do
    it 'responds successfully' do
      visit static_pages_home_path
      expect(page).to have_content('This is the home page')
      expect(page.title).to have_content('Ruby on Rails Tutorial Sample App')
    end
  end

  describe 'help' do  
    it 'responds successfully' do
      visit static_pages_help_path
      expect(page).to have_content('Get help on')
      expect(page.title).to have_content('Help')
    end
  end

  describe 'about' do
    it 'responds successfully' do
      visit static_pages_about_path
      expect(page).to have_content('About')
      expect(page.title).to have_content('About')
    end
  end

  describe 'contacts' do
    it 'responds successfully' do
      visit static_pages_contacts_path
      expect(page).to have_content('Contact')
      expect(page.title).to have_content('Contact')
    end
  end
end