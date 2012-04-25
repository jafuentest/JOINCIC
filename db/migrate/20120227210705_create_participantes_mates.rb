class CreateParticipantesMates < ActiveRecord::Migration
  def change
    create_table :participantes_mates do |t|
      t.integer :participante_id, :null => false
      t.integer :material_pop_id, :null => false
      t.boolean :entregado,       :null => false, :default => false
    end
  end
end
