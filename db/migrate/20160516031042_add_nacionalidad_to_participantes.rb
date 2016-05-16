class AddNacionalidadToParticipantes < ActiveRecord::Migration
  def change
    add_column :participantes, :nacionalidad, :string
  end
end
