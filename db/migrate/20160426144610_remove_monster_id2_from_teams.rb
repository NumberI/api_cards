class RemoveMonsterId2FromTeams < ActiveRecord::Migration
  def change
    remove_column :teams, :monster_id, :integer
  end
end
