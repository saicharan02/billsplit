class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :money_given, :float
    add_column :users, :money_took, :float
    add_column :users, :guest, :boolean
  end
end
