class RemoveCedulaFromPonente < ActiveRecord::Migration
  def change
    remove_column :ponentes, :cedula
  end
end
