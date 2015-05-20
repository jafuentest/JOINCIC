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
#  grupo_id       :integer
#

class Participante < ActiveRecord::Base
  include Persona
  
  self.include_root_in_json = true
  
  belongs_to :zona
  belongs_to :grupo
  belongs_to :organizador
  
  has_many :preguntas
  has_many :participantes_mesas
  has_many :participantes_mates
  has_many :mesas_de_trabajo, :through => :participantes_mesas
  has_many :materiales_pop,   :through => :participantes_mates
  has_and_belongs_to_many :rifas
  
  validates :cedula,        :numericality => true,
                            :uniqueness => true
                            
  validates :nombre,        :format => { :with => TEXTO_REGEX }
                            
  validates :seg_nombre,    :allow_blank => true,
                            :format => { :with => TEXTO_REGEX }
                            
  validates :apellido,      :format => { :with => TEXTO_REGEX }
                            
  validates :seg_apellido,  :allow_blank => true,
                            :format => { :with => TEXTO_REGEX }
                            
  validates :telefono,      :numericality => true,
                            :length => { :is => 11}
                            
  validates :correo,        :format => { :with => EMAIL_REGEX },
                            :uniqueness => { :case_sensitive => false }
                            
  validates :direccion,     :format => { :with => TEXTO_REGEX }
                            
  validates :institucion,   :format => { :with => TEXTO_REGEX }
                            
  validates :entrada,       :presence => true,
                            :uniqueness => { :scope => :zona_id }
                            
  validates :deposito,      :allow_blank => true,
                            :format => { :with => /\A[\d]+\z/i }
  
  def edad
    hoy = Date.today
    edad = hoy.year - fecha_nac.year
    if ((hoy.month < fecha_nac.month) || ((hoy.day < fecha_nac.day) && (hoy.month == fecha_nac.month)))
      edad = edad - 1
    end
    edad
  end
  
  def numeroDeMesasGanadas
    participantes_mesas.count(:conditions => { :seleccionado => true })
  end
end
