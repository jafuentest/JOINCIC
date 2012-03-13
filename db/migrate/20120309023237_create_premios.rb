class CreatePremios < ActiveRecord::Migration
  def change
    create_table :premios do |t|
      t.string  :nombre,          :null => false, :limit => 25
      t.integer :rifa_id,         :null => false
      t.integer :patrocinante_id, :null => false
      t.integer :participante_id
    end
  end
end
