class CreateUserRanks < ActiveRecord::Migration[5.0]
  def change
    create_table :agent_ranks do |t|
      t.string :name
      t.integer :rank
      t.string :remark

      t.timestamps
    end
  end
end
