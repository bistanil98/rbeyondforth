class AddAttachmentProfileImageToSocialMedia < ActiveRecord::Migration
  def self.up
    change_table :social_media do |t|
      t.attachment :profile_image
    end
  end

  def self.down
    remove_attachment :social_media, :profile_image
  end
end
