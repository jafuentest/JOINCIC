class AddAceptadaToPregunta < ActiveRecord::Migration
  def change
    add_column :preguntas, :aceptada, :boolean
  end
end
