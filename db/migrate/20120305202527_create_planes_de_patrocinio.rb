class CreatePlanesDePatrocinio < ActiveRecord::Migration
  def change
    create_table :planes_de_patrocinio do |t|
      t.string  :nombre,      :null => false, :limit => 10
      t.integer :precio,      :null => false
      t.text    :beneficios,  :null => false
    end
  end
end
