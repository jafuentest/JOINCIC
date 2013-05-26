class CreateGrupos < ActiveRecord::Migration
  def change
    create_table :grupos do |t|
      t.string :login, :null => false, :limit => 20
      t.string :clave, :null => false, :limit => 20
    end
  end
end
