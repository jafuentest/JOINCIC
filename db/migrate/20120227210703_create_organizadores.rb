class CreateOrganizadores < ActiveRecord::Migration
  def change
    create_table :organizadores do |t|
      t.string  :usuario,       :null => false, :limit => 15
      t.string  :clave,         :null => false, :limit => 15
      t.integer :cedula,        :null => false
      t.string  :nombre,        :null => false, :limit => 15
      t.string  :apellido,      :null => false, :limit => 15
      t.date    :fecha_nac,     :null => false
      t.string  :telefono,      :null => false, :limit => 11
      t.string  :correo,        :null => false, :limit => 25
      t.string  :direccion,     :null => false, :limit => 50
      t.string  :institucion,   :null => false, :limit => 5
      t.integer :nivel,         :null => false
      t.string  :tipo_nivel,    :null => false, :limit => 9
      t.string  :coordinacion,  :null => false, :limit => 15
      t.boolean :coordinador,   :null => false, :default => false
      t.string  :seg_nombre,    :limit => 15
      t.string  :seg_apellido,  :limit => 15
    end
  end
end
