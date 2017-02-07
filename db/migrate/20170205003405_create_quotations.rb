class CreateQuotations < ActiveRecord::Migration[5.0]
  def change
    create_table :quotations do |t|
      t.integer :price
      t.integer :product_id
      t.integer :agent_rank_id

      t.timestamps
    end
  end
end
