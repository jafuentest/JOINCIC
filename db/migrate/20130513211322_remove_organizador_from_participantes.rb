class RemoveOrganizadorFromParticipantes < ActiveRecord::Migration
  def up
    remove_column :participantes, :organizador
  end

  def down
    add_column :participantes, :organizador, :integer
  end
end
