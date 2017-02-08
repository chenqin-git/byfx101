class AddAgentRankIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :agent_rank_id, :integer
  end
end
