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
#  telefono2    :string(11)
#

class Ponente < ActiveRecord::Base
  include Persona
  
  has_many :mesas_de_trabajo
  has_many :ponencias

  email_regex	= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  texto_regex   = /\A[a-z �?É�?ÓÚÑáéíóúñ]+\z/i
  palabra_regex	= /\A[a-z�?É�?ÓÚÑáéíóúñ]+\z/i
  
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
  
end
