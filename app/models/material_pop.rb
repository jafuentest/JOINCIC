# == Schema Information
#
# Table name: materiales_pop
#
#  id       :integer          not null, primary key
#  nombre   :string(20)       not null
#  cantidad :integer          not null
#

class MaterialPop < ActiveRecord::Base
  has_many :participantes_mates
  has_many :participantes, through: :participante_mate
  
  validates :nombre,   format: { with: TEXTO_REGEX }

  validates :cantidad, presence: true
  
  def noHaSidoEntregado
    participantes_mates.count(conditions: { entregado: true }) == 0
  end
  
  def existencia
    cantidad - participantes_mates.count(conditions: { entregado: true })
  end
  
  def porEntregar
    Participante.all.size - participantes_mates.count(conditions: { entregado: true })
  end
  
  def disponibilidad
    cantidad - Participante.all.size
  end
  
  def disponible
    existencia > 0
  end
end
