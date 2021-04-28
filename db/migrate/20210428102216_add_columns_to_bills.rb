class AddColumnsToBills < ActiveRecord::Migration[6.1]
  def change
    add_column :guests, :bill_id, :integer
    add_column :guests, :user_id, :integer
  end
end
