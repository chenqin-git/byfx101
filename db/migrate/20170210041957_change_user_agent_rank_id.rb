class ChangeUserAgentRankId < ActiveRecord::Migration[5.0]
  def up
    change_column_default :users, :agent_rank_id, 1
  end

  def down
    change_column_default :users, :agent_rank_id, nil
  end
end
