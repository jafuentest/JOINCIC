class RemovePrioridadFromParticipantesMesas < ActiveRecord::Migration
  def up
    remove_column :participantes_mesas, :prioridad
  end

  def down
  end
end
