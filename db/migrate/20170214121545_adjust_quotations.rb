class AdjustQuotations < ActiveRecord::Migration[5.0]
  def change
    remove_column :quotations, :price, :integer
    add_column :quotations, :price, :decimal, :precision => 8, :scale => 2
  end
end
