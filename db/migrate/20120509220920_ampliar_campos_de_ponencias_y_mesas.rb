class AmpliarCamposDePonenciasYMesas < ActiveRecord::Migration
  def change
    change_column :ponencias,        :titulo, :string, :null => false, :limit => 255
    change_column :ponencias,        :tema,   :string, :null => false, :limit => 50
    change_column :mesas_de_trabajo, :titulo, :string, :null => false, :limit => 255
    change_column :mesas_de_trabajo, :tema,   :string, :null => false, :limit => 50
    change_column :mesas_de_trabajo, :lugar,  :string, :null => false, :limit => 50
  end
end
