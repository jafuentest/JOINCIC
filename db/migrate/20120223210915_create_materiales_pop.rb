class CreateMaterialesPop < ActiveRecord::Migration
  def change
    create_table :materiales_pop do |t|
      t.string :nombre
      t.integer :cantidad
    end
  end
end
