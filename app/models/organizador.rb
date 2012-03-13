class Organizador < ActiveRecord::Base
  email_regex	= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  login_regex	= /\A[a-z0-9\-_]+\z/i
  texto_regex	= /[[a-z]+\s]+\z/i
  palabra_regex	= /\A[a-z]+\z/i
  
  validates :usuario,      :format => { :with => login_regex },
                           :uniqueness => { :case_sensitive => false }
                           
  validates :clave,        :presence => true,
                           :length => { :maximum => 15 }
                           
  validates :cedula,       :numericality => true,
                           :uniqueness => true
  
  validates :nombre,       :format => { :with => palabra_regex }
  
  validates :seg_nombre,   :allow_blank => true,
                           :format => { :with => palabra_regex }
                           
  validates :apellido,     :format => { :with => palabra_regex }
  
  validates :seg_apellido, :allow_blank => true,
                           :format => { :with => palabra_regex }
                           
  validates :telefono,     :numericality => true,
                           :length => { :is => 11}
                           
  validates :correo,       :format => { :with => email_regex },
                           :uniqueness => { :case_sensitive => false }
                           
  validates :direccion,    :format => { :with => texto_regex }
  
  validates :nivel,        :presence => true
  
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