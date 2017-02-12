class CreateOrderResults < ActiveRecord::Migration[5.0]
  def change
    create_table :order_results do |t|
      t.string :result
      t.string :message
      t.boolean :success
      t.string :operator
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
