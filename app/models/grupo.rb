# == Schema Information
#
# Table name: grupos
#
#  id    :integer          not null, primary key
#  login :string(20)       not null
#  clave :string(20)       not null
#

class Grupo < ActiveRecord::Base
  has_many :participantes
  has_many :problemas
  has_many :programas, :through => :problemas
  
  validates :clave,              :confirmation => true
  validates :clave_confirmation, :presence => true
  validates :login,              :uniqueness => { :case_sensitive => false }
 
  def comprobar_clave(pass)
    clave == pass
  end
 
  def self.comprobarGrupo(login, clave)
    grupo = find_by_login(login)
      return grupo if grupo && grupo.comprobar_clave(clave)
    return nil
  end
end
