class CreateParticipantesMesas < ActiveRecord::Migration
  def change
    create_table :participantes_mesas do |t|
      t.integer   :participante_id,     :null => false
      t.integer   :mesa_de_trabajo_id,  :null => false
      t.integer   :prioridad,           :null => false
      t.boolean   :seleccionado,        :default => false
      t.datetime  :created_at
    end
  end
end
