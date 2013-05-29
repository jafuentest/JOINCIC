class CreateProgramas < ActiveRecord::Migration
  def change
    create_table :programas do |t|
      t.integer  :problema_id, :null => false, :limit => 10
      t.integer  :grupo_id,    :null => false, :limit => 10
      t.string   :estado,      :default => 'procesando'
      t.binary   :data
      t.string   :filename
      t.string   :mime_type
      t.datetime :created_at
    end
  end
end
