class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :expire_period, :integer, default: 90
    add_column :users, :status_active, :boolean, default: true
    add_column :users, :password_updated_at, :timestamp
    add_column :users, :auth_token_expires_at, :timestamp
  end
end
