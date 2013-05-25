# == Schema Information
#
# Table name: organizadores
#
#  id           :integer          not null, primary key
#  usuario      :string(15)       not null
#  clave        :string(15)       not null
#  cedula       :integer          not null
#  nombre       :string(15)       not null
#  apellido     :string(15)       not null
#  fecha_nac    :date             not null
#  telefono     :string(11)       not null
#  correo       :string(50)       not null
#  direccion    :string(50)       not null
#  institucion  :string(7)        not null
#  nivel        :integer          not null
#  tipo_nivel   :string(9)        not null
#  coordinacion :string(15)       not null
#  coordinador  :boolean          default(FALSE), not null
#  seg_nombre   :string(15)
#  seg_apellido :string(15)
#  eliminado    :boolean
#

class Organizador < ActiveRecord::Base
  include Persona
  email_regex	 = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  login_regex  = /\A[a-z0-9\-_]+\z/i
  texto_regex  = /\A[a-z\d �?É�?ÓÚÑáéíóúñ,.]+[a-z\d�?É�?ÓÚÑáéíóúñ]+\z/i
  nombre_regex = /\A[a-z �?É�?ÓÚÑáéíóúñ]+[a-z�?É�?ÓÚÑáéíóúñ]+\z/i
  
  has_many :participantes
  
  validates :usuario,      :format => { :with => login_regex },
                           :uniqueness => { :case_sensitive => false }
                            
  validates :clave,         :presence => true,
                            :length => { :maximum => 15 }
                            
  validates :cedula,        :numericality => true,
                            :uniqueness => true
                            
  validates :nombre,        :format => { :with => nombre_regex }
                            
  validates :seg_nombre,    :allow_blank => true,
                            :format => { :with => nombre_regex }
                            
  validates :apellido,      :format => { :with => nombre_regex }
                            
  validates :seg_apellido,  :allow_blank => true,
                            :format => { :with => nombre_regex }
                            
  validates :telefono,      :numericality => true,
                            :length => { :is => 11}
                            
  validates :correo,       :format => { :with => email_regex },
                           :uniqueness => { :case_sensitive => false }
                            
  validates :direccion,    :format => { :with => texto_regex }
                            
  validates :nivel,         :presence => true
  
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
