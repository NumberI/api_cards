class AddMonsterIdToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :monster_id, :integer
  end
end
