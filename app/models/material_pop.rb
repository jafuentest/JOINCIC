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
