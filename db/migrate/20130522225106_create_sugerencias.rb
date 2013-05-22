class CreateSugerencias < ActiveRecord::Migration
  def change
    create_table :sugerencias do |t|
      t.string    :texto,      :null => false
      t.string    :nombre,     :limit => 30
      t.string    :correo,     :limit => 25
      t.datetime  :created_at, :null => false
    end
  end
end
