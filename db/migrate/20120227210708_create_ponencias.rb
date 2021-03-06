class CreatePonencias < ActiveRecord::Migration
  def change
    create_table :ponencias do |t|
      t.string  :titulo,          :null => false, :limit => 25
      t.string  :tema,            :null => false, :limit => 25
      t.string  :descripcion,     :null => false, :limit => 255
      t.date    :dia,             :null => false
      t.time    :hora_ini,        :null => false
      t.time    :hora_fin,        :null => false
      t.text    :requerimientos,  :null => false
      t.integer :ponente_id,      :null => false
      t.integer :patrocinante_id
    end
  end
end
