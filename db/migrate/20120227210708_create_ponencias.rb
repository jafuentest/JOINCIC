class CreatePonencias < ActiveRecord::Migration
  def change
    create_table :ponencias do |t|
      t.string  :titulo,          :null => false, :limit => 25
      t.string  :tema,            :null => false, :limit => 25
      t.string  :descripcion,     :null => false, :limit => 255
      t.date    :dia
      t.time    :hora_ini
      t.time    :hora_fin
      t.integer :ponente_id,      :null => false
      t.integer :patrocinante_id
    end
  end
end
