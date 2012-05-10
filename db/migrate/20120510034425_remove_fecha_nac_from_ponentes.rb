class RemoveFechaNacFromPonentes < ActiveRecord::Migration
  def change
    remove_column :ponentes, :fecha_nac
  end
end
