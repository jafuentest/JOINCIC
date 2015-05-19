class AddOrganizadorToParticipantesAgain < ActiveRecord::Migration
  def change
    add_column :participantes, :organizador_id, :integer
  end
end
