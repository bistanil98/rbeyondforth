class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :blog_title
      t.text :blog_desc

      t.timestamps null: false
    end
  end
end
