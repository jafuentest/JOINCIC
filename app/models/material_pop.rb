class MaterialPop < ActiveRecord::Base
  has_many :participantes_mates
  has_many :participantes, :through => :participante_mate
  
  palabra_regex	= /\A[a-z]+\z/i
  
  validates :nombre,   :format => { :with => palabra_regex }
  validates :cantidad, :presence => true
  
  def existencia
    cantidad - participantes_mates.count(:conditions => { :entregado => true })
  end
  
  def deuda
    Participante.all.size - participantes_mates.count(:conditions => { :entregado => true })
  end
  
  def disponibilidad
    cantidad - Participante.all.size
  end
end
