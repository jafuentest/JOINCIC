class Pregunta < ActiveRecord::Base
  scope :aceptada, where(:aceptada => true)

  belongs_to :participante
  belongs_to :ponencia

  validates :mensaje, :presence => true, :length => { :in => 5..255 }
  validates :participante_id, :presence => true

end
