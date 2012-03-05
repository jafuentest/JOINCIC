class CreateMaterialesPop < ActiveRecord::Migration
  def change
    create_table :materiales_pop do |t|
      t.string  :nombre,    :null => false, :limit => 20
      t.integer :cantidad,  :null => false
    end
  end
end
