class CreateParticipantesMesas < ActiveRecord::Migration
  def change
    create_table :participantes_mesas do |t|
      t.integer   :id_par,        :null => false
      t.integer   :id_mesa,       :null => false
      t.integer   :prioridad,     :null => false
      t.boolean   :seleccionado,  :default => 0
      t.datetime  :created_at     
    end
  end
end
