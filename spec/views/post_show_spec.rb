require 'rails_helper'
RSpec.describe 'Post show', type: :feature do
  before(:each) do
    # rubocop: disable Layout/LineLength

    @user = User.create(name: 'Rito',
                        photo: 'https://www.thoughtco.com/thmb/0I-Uw-0rcc6MUzcZJauNGKR9JzA=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/male-computer-programmer-using-laptop-at-desk-in-office-755650739-5c5bb32346e0fb0001f24d3d.jpg', bio: 'Teacher from Mexico.', posts_counter: 0)

    @post = Post.create(author: @user, title: 'Hello', text: 'This is my first post', comments_conter: 0,
                        likes_counter: 0)
    # rubocop: enable Layout/LineLength

    @first_comment = Comment.create(post: @post, author: @user, text: 'Hi Rito!')

    @second_comment = Comment.create(post: @post, author: @user, text: 'Hola Rito!')
    @third_comment = Comment.create(post: @post, author: @user, text: 'Salam Rito!')

    visit user_posts_path(@user, @post)
  end

  describe 'post show page' do
    it 'shows the post title' do
      expect(page).to have_content @post.title
    end

    it 'shows who wrote the post' do
      expect(page).to have_content @post.author.name
    end

    it 'shows how many comments it has' do
      expect(@post.comments_conter).to eq(3)
    end

    it 'shows how many likes it has' do
      expect(@post.likes_counter).to eq(0)
    end

    it 'shows the post body' do
      expect(page).to have_content @post.text
    end

    it 'showd the username of each commentor' do
      expect(page).to have_content @first_comment.author.name
      expect(page).to have_content @second_comment.author.name
      expect(page).to have_content @third_comment.author.name
    end

    it 'shows the comment each commentor left' do
      expect(page).to have_content @first_comment.text
      expect(page).to have_content @second_comment.text
      expect(page).to have_content @third_comment.text
    end
  end
end

# I can see the username of each commentor.
# I can see the comment each commentor left.
