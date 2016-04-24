class RemoveFieldsFromOrganizador < ActiveRecord::Migration
  def change
    remove_column :organizadores, :cedula
    remove_column :organizadores, :fecha_nac
    remove_column :organizadores, :telefono
    remove_column :organizadores, :direccion
    remove_column :organizadores, :nivel
    remove_column :organizadores, :tipo_nivel
  end
end
