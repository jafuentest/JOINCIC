class CreateRifas < ActiveRecord::Migration
  def change
    create_table :rifas do |t|
      t.string  :nombre,  :null => false, :limit => 20
      t.integer :amount, :null => false
      t.integer :limit
    end
  end
end
