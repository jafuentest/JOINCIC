class AddGrupoToParticipantes < ActiveRecord::Migration
  def change
    add_column :participantes, :grupo_id, :integer
  end
end
