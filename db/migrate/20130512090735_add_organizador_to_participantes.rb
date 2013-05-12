class AddOrganizadorToParticipantes < ActiveRecord::Migration
  def change
    add_column :participantes, :organizador, :integer, :null => false
  end
end
