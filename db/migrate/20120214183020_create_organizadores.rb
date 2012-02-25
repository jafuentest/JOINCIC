class CreateOrganizadores < ActiveRecord::Migration
  def change
    create_table :organizadores do |t|
      t.string :usuario
      t.string :clave
      t.integer :ci_org
      t.string :nombre
      t.string :seg_nombre
      t.string :apellido
      t.string :seg_apellido
      t.date :fecha_nac
      t.string :telefono
      t.string :correo
      t.string :direccion
      t.string :institucion
      t.integer :nivel
      t.string :coordinacion
      t.boolean :coordinador
    end
  end
end
