class CreatePreguntas < ActiveRecord::Migration
  def change
    create_table :preguntas do |t|
      t.string  :mensaje, :null => false, :limit => 255
      t.integer :id_par,  :null => false
      t.integer :id_pon,  :null => false
    end
  end
end
