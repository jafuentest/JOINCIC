class Zona < ActiveRecord::Base
  has_many :participantes
  
  palabra_regex	= /\A[a-z]+\z/i
  
  validates :nombre,    :format => { :with => palabra_regex },
                        :uniqueness => true
                        
  validates :capacidad, :presence => true
  
  def disponibilidad
    capacidad - participantes.count
  end
end