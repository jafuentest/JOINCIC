class Organizador < ActiveRecord::Base
  email_regex	= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  login_regex	= /\A[a-z0-9\-_]+\z/i
  texto_regex   = /\A[a-z ÁÉÍÓÚÑáéíóúñ]+\z/i
  palabra_regex	= /\A[a-zÁÉÍÓÚÑáéíóúñ]+\z/i
  
  validates :usuario,      :format => { :with => login_regex },
                           :uniqueness => { :case_sensitive => false }
                           
  validates :clave,        :presence => true,
                           :length => { :maximum => 15 }
                           
  validates :cedula,       :numericality => true,
                           :uniqueness => true
  
  validates :nombre,       :format => { :with => palabra_regex }
  
  validates :seg_nombre,   :allow_blank => true,
                           :format => { :with => palabra_regex }
                           
  validates :apellido,     :format => { :with => texto_regex }
  
  validates :seg_apellido, :allow_blank => true,
                           :format => { :with => texto_regex }
                           
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
  
  def comprobarPass(pass)
	clave == pass
  end
	
  def self.comprobarOrganizador(nombre, pass)
	organizador = find_by_usuario(nombre)
	if (organizador != nil)
		return organizador if organizador.comprobarPass(pass)
	end
	nil
  end
end