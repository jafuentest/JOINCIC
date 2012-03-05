class Zona < ActiveRecord::Base
  has_many :participantes, :foreign_key => "id_zona"
  
  palabra_regex	= /\A[a-z]+\z/i
  
  validates :nombre,    :format => { :with => palabra_regex }
  validates :capacidad, :presence => true
end
