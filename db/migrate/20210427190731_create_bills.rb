class CreateBills < ActiveRecord::Migration[6.1]
  def change
    create_table :bills do |t|
      t.string :name
      t.text :description
      t.float :amount
      t.integer :user_id

      t.timestamps
    end
  end
end
