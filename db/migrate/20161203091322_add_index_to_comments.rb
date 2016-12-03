class AddIndexToComments < ActiveRecord::Migration
  def change
    add_index :comments, :user_id
    add_index :comments, :blog_id
  end
end
