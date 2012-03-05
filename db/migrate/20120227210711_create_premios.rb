class CreatePremios < ActiveRecord::Migration
  def change
    create_table :premios do |t|
      t.string :nombre,     :null => false, :limit => 50
      t.integer :cantidad,  :null => false
      t.integer :id_pat,    :null => false
      t.integer :id_rifa,   :null => false
    end
  end
end
