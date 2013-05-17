# == Schema Information
#
# Table name: participantes
#
#  id             :integer          not null, primary key
#  cedula         :integer          not null
#  nombre         :string(15)       not null
#  apellido       :string(15)       not null
#  fecha_nac      :date             not null
#  telefono       :string(11)       not null
#  correo         :string(50)       not null
#  direccion      :string(50)       not null
#  institucion    :string(20)       not null
#  nivel          :integer          not null
#  tipo_nivel     :string(9)        not null
#  zona_id        :integer          not null
#  entrada        :integer          not null
#  organizador_id :integer          not null
#  comida         :boolean          default(FALSE), not null
#  created_at     :datetime         not null
#  seg_nombre     :string(15)
#  seg_apellido   :string(15)
#  deposito       :integer
#  eliminado      :boolean
#

class Participante < ActiveRecord::Base
  belongs_to :zona
  belongs_to :organizador
  
  has_many :preguntas
  has_many :participantes_mesas
  has_many :participantes_mates
  has_many :mesas_de_trabajo, :through => :participantes_mesas
  has_many :materiales_pop,   :through => :participantes_mates
  has_and_belongs_to_many :rifas

  email_regex  = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  texto_regex  = /\A[a-z\d ÁÉÍÓÚÑáéíóúñ,.]+[a-z\dÁÉÍÓÚÑáéíóúñ]+\z/i
  nombre_regex = /\A[a-z ÁÉÍÓÚÑáéíóúñ]+[a-zÁÉÍÓÚÑáéíóúñ]+\z/i
  
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
                            
  validates :correo,        :format => { :with => email_regex },
                            :uniqueness => { :case_sensitive => false }
                            
  validates :direccion,     :format => { :with => texto_regex }
                            
  validates :institucion,   :format => { :with => texto_regex }
                            
  validates :nivel,         :presence => true
                            
  validates :entrada,       :presence => true,
                            :uniqueness => true
                            
  validates :deposito,      :allow_blank => true,
                            :format => { :with => /\A\d\z/i }
                            
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
  
  def edad
    hoy = Date.today
    edad = hoy.year - fecha_nac.year
    if ((hoy.month < fecha_nac.month) || ((hoy.day < hoy.day) && (hoy.month == fecha_nac.month)))
      edad = edad - 1
    end
    edad
  end
  
  def numDeMesasGanadas
    participantes_mesas.count(:conditions => { :seleccionado => true })
  end
end
