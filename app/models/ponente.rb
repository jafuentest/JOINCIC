class Ponente < ActiveRecord::Base
  has_many :mesas_de_trabajo
  has_many :ponencias

  email_regex	= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  texto_regex   = /\A[a-z ÁÉÍÓÚÑáéíóúñ]+\z/i
  palabra_regex	= /\A[a-zÁÉÍÓÚÑáéíóúñ]+\z/i
  
  validates :nombre,        :format => { :with => palabra_regex }
  
  validates :seg_nombre,    :allow_blank => true,
                            :format => { :with => palabra_regex }
  
  validates :apellido,      :format => { :with => texto_regex }
  
  validates :seg_apellido,  :allow_blank => true,
                            :format => { :with => texto_regex }
  
  validates :telefono,      :allow_blank => true,
                            :numericality => true,
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
    if seg_nombre.nil?
      ret = nombre
    else
      ret = nombre + " " + seg_nombre
    end
    ret
  end
  
  def apellidos
    if seg_apellido.nil?
      ret = apellido
    else
      ret = apellido + " " + seg_apellido
    end
    ret
  end
end