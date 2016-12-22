class Comment < ActiveRecord::Base
  belongs_to :blog
  belongs_to :user
  scope :most_recent, -> {order(id: :desc)}
end
