class Participante < ActiveRecord::Base
  belongs_to :zona
  
  has_many :preguntas
  has_many :participantes_mesas
  has_many :participantes_mates
  has_many :mesas_de_trabajo, :through => :participantes_mesas
  has_many :materiales_pop,   :through => :participantes_mates

  email_regex	= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  texto_regex	= /[[a-z]+\s]+\z/i
  palabra_regex	= /\A[a-z]+\z/i
  
  validates :cedula,        :numericality => true,
                            :uniqueness => true
                            
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
  
  def nombres
    nombre + " " + seg_nombre
  end
  
  def apellidos
    apellido + " " + seg_apellido
  end
end