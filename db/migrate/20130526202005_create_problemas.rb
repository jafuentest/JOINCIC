class CreateProblemas < ActiveRecord::Migration
  def change
    create_table :problemas do |t|
      t.string :titulo
      t.text :enunciado
      t.text :entradas
      t.text :salidas
      t.datetime :fin_de_entrega
      t.datetime :updated_at
    end
  end
end
