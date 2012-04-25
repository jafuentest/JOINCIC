class CreatePatrocinantes < ActiveRecord::Migration
  def change
    create_table :patrocinantes do |t|
      t.string  :rif,         :null => false, :limit => 12
      t.string  :nombre,      :null => false, :limit => 30
      t.integer :aporte,      :null => false
      t.integer :plan_id,     :null => false
      t.text    :comentario
      t.binary  :logo
    end
  end
end
