# == Schema Information
#
# Table name: organizadores
#
#  id           :integer          not null, primary key
#  usuario      :string(15)       not null
#  clave        :string(15)       not null
#  nombre       :string(15)       not null
#  apellido     :string(15)       not null
#  correo       :string(50)       not null
#  institucion  :string(7)        not null
#  coordinacion :string(15)       not null
#  coordinador  :boolean          default(FALSE), not null
#  seg_nombre   :string(15)
#  seg_apellido :string(15)
#  eliminado    :boolean
#

class Organizador < ActiveRecord::Base
  include Persona

  has_many :participantes
 
  validates :usuario,       :format => { :with => LOGIN_REGEX },
                            :uniqueness => { :case_sensitive => false }

  validates :clave,         :presence => true,
                            :length => { :maximum => 15 }

  validates :nombre,        :format => { :with => TEXTO_REGEX }

  validates :seg_nombre,    :allow_blank => true,
                            :format => { :with => TEXTO_REGEX }

  validates :apellido,      :format => { :with => TEXTO_REGEX }

  validates :seg_apellido,  :allow_blank => true,
                            :format => { :with => TEXTO_REGEX }

  validates :correo,        :format => { :with => EMAIL_REGEX },
                            :uniqueness => { :case_sensitive => false }

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
