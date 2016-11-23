class AddIndexToSocialMedia < ActiveRecord::Migration
  def change
    add_column :social_media, :user_id, :integer
    add_column :social_media, :profile_name, :string
    add_index :social_media, :user_id
  end
end
