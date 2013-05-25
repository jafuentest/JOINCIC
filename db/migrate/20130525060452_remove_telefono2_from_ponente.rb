class RemoveTelefono2FromPonente < ActiveRecord::Migration
  def up
    remove_column :ponentes, :telefono2
  end

  def down
    add_column :ponentes, :telefono2, :string
  end
end
