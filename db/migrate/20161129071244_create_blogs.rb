class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :blog_title
      t.text :blog_description

      t.timestamps null: false
    end
  end
end
