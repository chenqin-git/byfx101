class AddStateAndResultToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :state, :integer, default: 0
    add_column :orders, :serial_number, :string, index: true
  end
end
