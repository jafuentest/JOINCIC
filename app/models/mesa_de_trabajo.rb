# == Schema Information
#
# Table name: mesas_de_trabajo
#
#  id              :integer          not null, primary key
#  titulo          :string(255)      not null
#  tema            :string(50)       not null
#  descripcion     :string(255)      not null
#  dia             :date             not null
#  hora_ini        :time             not null
#  hora_fin        :time             not null
#  lugar           :string(50)       not null
#  capacidad       :integer          not null
#  requerimientos  :text(65535)      not null
#  sorteada        :boolean          default("0"), not null
#  ponente_id      :integer
#  patrocinante_id :integer
#

class MesaDeTrabajo < ActiveRecord::Base
  belongs_to :ponente
  belongs_to :patrocinante
  has_many   :participantes_mesas
  has_many   :participantes, through: :participantes_mesas
  
  self.include_root_in_json = true
  
  validates :titulo,    presence: true
  validates :capacidad, presence: true
end
