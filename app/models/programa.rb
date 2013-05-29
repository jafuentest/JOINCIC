# == Schema Information
#
# Table name: programas
#
#  id          :integer          not null, primary key
#  problema_id :integer          not null
#  grupo_id    :integer          not null
#  estado      :string(255)      default("procesando")
#  data        :binary
#  filename    :string(255)
#  mime_type   :string(255)
#  created_at  :datetime
#

class Programa < ActiveRecord::Base
  belongs_to :problema
  belongs_to :grupo
  
  validates :problema_id, :presence => true
  validates :data, :presence => true
end
