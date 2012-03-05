class CreatePonencias < ActiveRecord::Migration
  def change
    create_table :ponencias do |t|
      t.string :titulo,       :null => false, :limit => 25
      t.string :tema,         :null => false, :limit => 25
      t.string :descripcion,  :null => false, :limit => 255
      t.date :dia,            :null => false
      t.time :hora_ini,       :null => false
      t.time :hora_fin,       :null => false
      t.integer :id_ponente,  :null => false
      t.integer :id_pat
    end
  end
end
