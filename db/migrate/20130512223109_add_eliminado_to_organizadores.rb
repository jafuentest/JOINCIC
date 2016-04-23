class AddEliminadoToOrganizadores < ActiveRecord::Migration
  def change
    add_column :organizadores, :eliminado, :boolean, null: false, default: false
  end
end
