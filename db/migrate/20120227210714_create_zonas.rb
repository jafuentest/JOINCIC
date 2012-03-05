class CreateZonas < ActiveRecord::Migration
  def change
    create_table :zonas do |t|
      t.string  :nombre,    :null => false, :limit => 10
      t.integer :capacidad, :null => false
    end
  end
end
