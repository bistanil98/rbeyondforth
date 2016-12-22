class AddColumnsToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :blog_visit_count, :integer, :default => 0
    add_column :blogs, :featured_flag, :boolean, :default => false
  end
end
