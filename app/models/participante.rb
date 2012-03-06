class Participante < ActiveRecord::Base
  belongs_to :zona, :foreign_key => "id_zona"
  has_many :participantes_mates, :foreign_key => "id_par"
  has_many :materiales_pop, :through => :participante_mate, :foreign_key => "id_mate"
  has_many :participantes_mesas, :foreign_key => "id_par"
  has_many :mesas_de_trabajo, :through => :participante_mesa, :foreign_key => "id_mesa"
  has_many :preguntas, :foreign_key => "id_par"

  email_regex	= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  texto_regex	= /[[a-z]+\s]+\z/i
  palabra_regex	= /\A[a-z]+\z/i
  
  validates :cedula,        :numericality => true
  validates :nombre,        :format => { :with => palabra_regex }
  validates :seg_nombre,    :allow_blank => true,
                            :format => { :with => palabra_regex }
  validates :apellido,      :format => { :with => palabra_regex }
  validates :seg_apellido,  :allow_blank => true,
                            :format => { :with => palabra_regex }
  validates :telefono,      :numericality => true,
                            :length => { :is => 11}
  validates :correo,        :format => { :with => email_regex },
                            :uniqueness => { :case_sensitive => false }
  validates :direccion,     :format => { :with => texto_regex }
  validates :institucion,   :format => { :with => texto_regex }
	validates :nivel,         :presence => true
  
  def nombreCompleto
    nombre + " " + apellido
  end
end

