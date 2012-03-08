class CreatePlanes < ActiveRecord::Migration
  def change
    create_table :planes do |t|
      t.string :nombre
      t.integer :precio
      t.text :beneficios

      t.timestamps
    end
  end
end
