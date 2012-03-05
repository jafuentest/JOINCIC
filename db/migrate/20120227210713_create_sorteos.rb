class CreateSorteos < ActiveRecord::Migration
  def change
    create_table :sorteos do |t|
      t.integer :id_par,    :null => false
      t.integer :id_premio, :null => false
      t.boolean :entregado, :default => 0
    end
  end
end
