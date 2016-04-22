# == Schema Information
#
# Table name: ponentes
#
#  id           :integer          not null, primary key
#  nombre       :string(15)       not null
#  apellido     :string(15)       not null
#  telefono     :string(11)       not null
#  correo       :string(50)       not null
#  institucion  :string(20)       not null
#  seg_nombre   :string(15)
#  seg_apellido :string(15)
#

class Ponente < ActiveRecord::Base
  include Persona

  has_many :mesas_de_trabajo
  has_many :ponencias

  self.include_root_in_json = true

  validates :nombre,       format: { with: TEXTO_REGEX }

  validates :seg_nombre,   format: { with: TEXTO_REGEX }, allow_blank: true

  validates :apellido,     format: { with: TEXTO_REGEX }

  validates :seg_apellido, format: { with: TEXTO_REGEX }, allow_blank: true

  validates :telefono,     allow_blank: true, numericality: true, length: { is: 11}

  validates :correo,       format: { with: EMAIL_REGEX }, allow_blank: true, uniqueness: { case_sensitive: false }

  validates :institucion,  format: { with: TEXTO_REGEX }
end
