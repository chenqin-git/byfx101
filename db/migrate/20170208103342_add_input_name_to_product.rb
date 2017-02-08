class AddInputNameToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :input_name, :string
  end
end
