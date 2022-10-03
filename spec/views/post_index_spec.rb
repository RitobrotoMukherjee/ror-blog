require 'rails_helper'
RSpec.describe 'Post index', type: :feature do
  before(:each) do
    # rubocop: disable Layout/LineLength

    @user = User.create(name: 'Rito',
                              photo: 'https://www.thoughtco.com/thmb/0I-Uw-0rcc6MUzcZJauNGKR9JzA=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/male-computer-programmer-using-laptop-at-desk-in-office-755650739-5c5bb32346e0fb0001f24d3d.jpg', bio: 'Teacher from Mexico.', posts_counter: 0)
    

    @post = Post.create(author: @user, title: 'Hello', text: 'This is my first post', comments_conter: 0,
                              likes_counter: 0)
    # rubocop: enable Layout/LineLength

    @first_comment = Comment.create(post: @post, author: @user, text: 'Hi Rito!')
    @second_comment = Comment.create(post: @post, author: @user, text: 'Hola Rito!')
    @third_comment = Comment.create(post: @post, author: @user, text: 'Bonjour Rito!')

    visit user_posts_path(@user)
  end
  describe 'post index page' do
    it 'shows the user profile picture' do
      expect(page).to have_xpath("//img[contains(@src,'https://www.thoughtco.com/thmb/0I-Uw-0rcc6MUzcZJauNGKR9JzA=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/male-computer-programmer-using-laptop-at-desk-in-office-755650739-5c5bb32346e0fb0001f24d3d.jpg')]")
    end

    it 'shows the username' do
      expect(page).to have_content @user.name
    end

    it 'shows the number of posts each user has written' do
      expect(@user.posts_counter).to eq(3)
    end

    it 'shows the post\'s title' do
      expect(page).to have_content @post.title
    end

    it 'shows some of the post\'s body' do
      expect(page).to have_content 'first post'
    end

    it 'shows the first comments on a post' do
      expect(page).to have_content @first_comment.text
    end

    it 'shows how many comments a post has' do
      expect(@post.comments_conter).to eq(6)
    end

    it 'When I click on a post, it redirects me to that post\'s show page' do
      click_link @post.title
      expect(page).to have_current_path user_post_path(@user, @post)
    end
  end
end

# I can see the first comments on a post.
# I can see how many comments a post has.
# I can see how many likes a post has.
# When I click on a post, it redirects me to that post's show page.
