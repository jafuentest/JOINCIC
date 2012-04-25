class CreateMesasDeTrabajo < ActiveRecord::Migration
  def change
    create_table :mesas_de_trabajo do |t|
      t.string  :titulo,          :null => false, :limit => 25
      t.string  :tema,            :null => false, :limit => 25
      t.string  :descripcion,     :null => false
      t.date    :dia,             :null => false
      t.time    :hora_ini,        :null => false
      t.time    :hora_fin,        :null => false
      t.string  :lugar,           :null => false, :limit => 25
      t.integer :capacidad,       :null => false
      t.text    :requerimientos,  :null => false
      t.boolean :sorteada,        :null => false, :default => false
      t.integer :ponente_id
      t.integer :patrocinante_id
    end
  end
end
