class MesaDeTrabajo < ActiveRecord::Base
  belongs_to :ponente
  belongs_to :patrocinante
  has_many   :participantes_mesas
  has_many   :participantes, :through => :participantes_mesas
  
  texto_regex	= /[[a-z]+\s]+\z/i
  palabra_regex	= /\A[a-z]+\z/i
  
  validates :titulo,         :format => { :with => texto_regex }
  validates :tema,           :format => { :with => texto_regex }
  validates :descripcion,    :format => { :with => texto_regex }
  validates :capacidad,      :presence => true
  validates :requerimientos, :format => { :with => texto_regex }
end
