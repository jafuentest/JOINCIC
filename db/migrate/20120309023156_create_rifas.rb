class CreateRifas < ActiveRecord::Migration
  def change
    create_table :rifas do |t|
      t.string :nombre, :null => false, :limit => 20
    end
  end
end
