class CreateSocialMedia < ActiveRecord::Migration
  def change
    create_table :social_media do |t|
      t.string :provider
      t.string :uid
      t.string :social_email
      t.text :token
      t.timestamp :expire_at

      t.timestamps null: false
    end
  end
end
