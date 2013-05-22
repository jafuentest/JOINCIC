class AddEliminadoToOrganizadores < ActiveRecord::Migration
  def change
    add_column :organizadores, :eliminado, :boolean
  end
end
