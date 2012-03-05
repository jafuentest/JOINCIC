class CreateParticipantesMates < ActiveRecord::Migration
  def change
    create_table :participantes_mates do |t|
      t.integer :id_par,    :null => false
      t.integer :id_mate,   :null => false
      t.boolean :entregado, :null => false
    end
  end
end
