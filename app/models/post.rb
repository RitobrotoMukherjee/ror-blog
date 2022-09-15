class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  after_save :update_user_posts_count

  def update_user_posts_count
    author.increment!(:posts_counter)
  end

  def five_recent_comments
    comments.last(5)
  end
end
