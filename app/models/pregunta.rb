class Pregunta < ActiveRecord::Base
  belongs_to :participante
  belongs_to :ponencia
  
  validates :mensaje, :presence => true
end