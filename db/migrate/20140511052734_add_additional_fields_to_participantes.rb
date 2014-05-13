class AddAdditionalFieldsToParticipantes < ActiveRecord::Migration
  def change
	add_column :participantes, :carrera, :string
    add_column :participantes, :esEstudiante, :boolean
	add_column :participantes, :interesadoPasantia, :boolean
    add_column :participantes, :periodoPasantia, :string
    add_column :participantes, :intereses, :string
    add_column :participantes, :experiencia, :string
  end
end
