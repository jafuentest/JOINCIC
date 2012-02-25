class CreateParticipantes < ActiveRecord::Migration
  def change
    create_table :participantes do |t|
      t.integer :ci_par
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
      t.boolean :comida
      t.integer :id_zona
			t.boolean :eliminado
      t.datetime :created_at
    end
  end
end
