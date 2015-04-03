# == Schema Information
#
# Table name: ponencias
#
#  id              :integer          not null, primary key
#  titulo          :string(255)      not null
#  tema            :string(50)       not null
#  descripcion     :string(255)      not null
#  dia             :date             not null
#  hora_ini        :time             not null
#  hora_fin        :time             not null
#  requerimientos  :text             default(""), not null
#  ponente_id      :integer          not null
#  patrocinante_id :integer
#

class Ponencia < ActiveRecord::Base
  belongs_to :ponente
  belongs_to :patrocinante
  has_many   :preguntas
  
  self.include_root_in_json = true
  
  validates :titulo,    :presence => true
end
