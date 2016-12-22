#created on 29/nov/2016 by prateek darmwal
class Blog < ActiveRecord::Base
  extend FriendlyId
  friendly_id :blog_title, use: :slugged
  attr_accessor :tag_tokens
  belongs_to :user
  belongs_to :category
  has_many :blog_tags
  has_many :tags, through: :blog_tags
  has_many :comments
  attr_reader :tag_tokens
  scope :most_recent, -> {order(id: :desc)}
  #virtual attribute for blog model
  def blog_category_name #getter method for post_category_name
    category.try(:category_name)
  end

  def blog_category_name=(category_name) #setter method for post_category_name
    self.category = Category.find_by_category_name(category_name) if category_name.present?
  end

  def tag_tokens=(ids) #setter method for tag_tokens
    self.tag_ids = ids.split(",")
  end
  #it will be needed if we want user to create a new tag if typed texed doesn't match any record
  #replace this with above setter method
  # def tag_tokens=(tokens) #setter method for tag_tokens
  #   self.tag_ids = Tag
  # end

  #helper methods
  def should_generate_new_friendly_id?
    blog_title_changed?
  end

  def display_day_published
    "#{created_at.strftime('%-b %-d, %Y')}"
  end
  def display_day_updated
    "#{updated_at.strftime('%-b %-d, %Y')}"
  end
  def display_publisher_name
    "#{user.name}"
  end
  def display_publisher_email
    "#{user.email}"
  end
end
