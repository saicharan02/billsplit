class CreateDebts < ActiveRecord::Migration[6.1]
  def change
    create_table :debts do |t|
      t.float :amount
      t.string :debtor_name
      t.string :creditor_name
      t.float :bill_id
      t.integer :debtor_id
      t.integer :creditor_id

      t.timestamps
    end
  end
end
