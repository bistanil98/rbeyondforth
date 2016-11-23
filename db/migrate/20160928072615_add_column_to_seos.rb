class AddColumnToSeos < ActiveRecord::Migration
  def change
    add_column :seos, :errnum, :integer
  end
end
