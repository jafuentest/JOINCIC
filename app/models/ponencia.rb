class Ponencia < ActiveRecord::Base
  belongs_to :ponente
  belongs_to :patrocinante
  has_many   :preguntas
  
  texto_regex	= /[[a-z]+\s]+\z/i
  palabra_regex	= /\A[a-z]+\z/i
  
  validates :titulo,         :format => { :with => texto_regex }
  validates :tema,           :format => { :with => texto_regex }
  validates :descripcion,    :format => { :with => texto_regex }
  validates :requerimientos, :format => { :with => texto_regex }
end