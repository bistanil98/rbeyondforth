class AddIndexToBlogTags < ActiveRecord::Migration
  def change
    add_index :blog_tags, :blog_id
    add_index :blog_tags, :tag_id
  end
end
