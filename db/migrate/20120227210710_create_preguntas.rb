class CreatePreguntas < ActiveRecord::Migration
  def change
    create_table :preguntas do |t|
      t.string  :mensaje,         :null => false, :limit => 255
      t.integer :participante_id, :null => false
      t.integer :ponencia_id,     :null => false
    end
  end
end
