class CreateGuests < ActiveRecord::Migration[6.1]
  def change
    create_table :guests do |t|
      t.string :name
      t.float :money_paid
      t.float :money_to_pay

      t.timestamps
    end
  end
end
