class CreateZonas < ActiveRecord::Migration
  def change
    create_table :zonas do |t|
      t.string :nombre
      t.integer :capacidad
    end
  end
end
