class Ponente < ActiveRecord::Base
  has_many :mesas_de_trabajo
  has_many :ponencias

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
  
  validates :telefono2,     :allow_blank => true,
                            :numericality => true,
                            :length => { :is => 11}
  
  validates :correo,        :format => { :with => email_regex },
                            :uniqueness => { :case_sensitive => false }
  
  validates :institucion,   :format => { :with => texto_regex }
  
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