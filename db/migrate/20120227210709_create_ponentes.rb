class CreatePonentes < ActiveRecord::Migration
  def change
    create_table :ponentes do |t|
      t.integer :cedula,        :null => false
      t.string  :nombre,        :null => false, :limit => 15
      t.string  :apellido,      :null => false, :limit => 15
      t.string  :telefono,      :null => false, :limit => 11
      t.string  :correo,        :null => false, :limit => 25
      t.string  :institucion,   :null => false, :limit => 20
      t.string  :seg_nombre,    :limit => 15
      t.string  :seg_apellido,  :limit => 15
      t.string  :telefono2,     :limit => 11
    end
  end
end
