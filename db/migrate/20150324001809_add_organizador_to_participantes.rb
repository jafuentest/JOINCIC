class AddOrganizadorToParticipantes < ActiveRecord::Migration
  def change
    add_column :participantes, :organizador_id, :integer
  end
end
