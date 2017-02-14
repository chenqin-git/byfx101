class CreateAccountBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :account_books do |t|
      t.references :user, foreign_key: true
      t.decimal :amount, :precision => 8, :scale => 2
      t.integer :transaction_type
      t.integer :order_id
      t.string :deposit_reference_no
      t.string :operator
      t.string :remark
      t.decimal :balance, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
