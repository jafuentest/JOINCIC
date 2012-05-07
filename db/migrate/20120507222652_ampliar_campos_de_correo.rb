class AmpliarCamposDeCorreo < ActiveRecord::Migration
  def up
    change_column :participantes, :correo, :string, :null => false, :limit => 50
    change_column :organizadores, :correo, :string, :null => false, :limit => 50
    change_column :ponentes, :correo, :string, :null => false, :limit => 50
  end
end
