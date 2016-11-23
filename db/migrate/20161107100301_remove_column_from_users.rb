class RemoveColumnFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :login, :string
    remove_column :users, :password, :string
    remove_column :users, :provider, :string
    remove_column :users, :token, :text
    remove_column :users, :expire_at, :timestamp
    remove_column :users, :uid, :string
  end
end
