class AdjustOrderResult < ActiveRecord::Migration[5.0]
  def change
    remove_column :order_results, :success, :boolean
    add_column :order_results, :success_num, :integer
  end
end
