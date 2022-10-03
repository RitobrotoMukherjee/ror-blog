require 'rails_helper'
RSpec.describe 'User show', type: :feature do
  before(:each) do
    # rubocop: disable Layout/LineLength

    @user = User.create(name: 'Tom',
                              photo: 'https://www.thoughtco.com/thmb/0I-Uw-0rcc6MUzcZJauNGKR9JzA=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/male-computer-programmer-using-laptop-at-desk-in-office-755650739-5c5bb32346e0fb0001f24d3d.jpg', bio: 'Teacher from Mexico.', posts_counter: 0)

    @first_post = Post.create(author: @user, title: 'Hello', text: 'This is my first post', comments_conter: 0, likes_counter: 0)
    @second_post = Post.create(author: @user, title: 'Hola', text: 'This is my second post', comments_conter: 0, likes_counter: 0)
    @third_post = Post.create(author: @user, title: 'Namaste', text: 'This is my third post',comments_conter: 0, likes_counter: 0)
    # rubocop: enable Layout/LineLength
    visit user_path(@user)
  end

  describe 'user show page' do
    it 'shows the user profile picture' do
      expect(page).to have_xpath("//img[contains(@src,'https://www.thoughtco.com/thmb/0I-Uw-0rcc6MUzcZJauNGKR9JzA=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/male-computer-programmer-using-laptop-at-desk-in-office-755650739-5c5bb32346e0fb0001f24d3d.jpg')]")
    end

    it 'shows the username' do
      expect(page).to have_content @user.name
    end

    it 'shows the number of posts each user has written' do
      expect(@user.posts_counter).to eq(3)
    end

    it 'shows the user bio' do
      expect(page).to have_content @user.bio
    end

    it 'shows the user\'s first 3 posts' do
      expect(page).to have_content @first_post.title
      expect(page).to have_content @second_post.title
      expect(page).to have_content @third_post.title
    end

    it 'shows the button that lets me view all of a user\'s posts' do
      expect(page).to have_link 'See all posts'
    end

    it 'When I click on a user post, it redirects me to that post\'s show page' do
      click_link 'Namaste'
      expect(page).to have_current_path user_post_path(@user, @third_post)
    end

    it 'When I click to see all posts, it redirects me to the user\'s post\'s index page' do
      click_link 'See all posts'
      expect(page).to have_current_path user_posts_path(@user)
    end
  end
end