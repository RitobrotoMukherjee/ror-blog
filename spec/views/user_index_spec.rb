require 'rails_helper'
RSpec.describe 'users#index', type: :feature do
  describe 'user index page' do
    before(:each) do
      @user1 = User.create(name: 'Rito', photo: 'Tom.png', bio: 'bio', posts_counter: 0)
      @user2 = User.create(name: 'Amy', bio: 'bio', photo: 'Tom.png')
      @user3 = User.create(name: 'Jerry', bio: 'bio', photo: 'Tom.png')

      visit root_path
    end

    it 'shows the usernames of all users' do
      expect(page).to have_content('Jerry')
      expect(page).to have_content('Rito')
      expect(page).to have_content('Amy')
    end

    it "Shows the user's photo" do
      all('img').each do |i|
        expect(i[:src]).to eq('Tom.png')
      end
    end

    it 'shows the number of posts each user has written' do
      expect(page).to have_content('0')
    end
  end
end
