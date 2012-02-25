class Participante < ActiveRecord::Base
  belongs_to :zona

  email_regex	= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  texto_regex	= /[[a-z]+\s]+\z/i
  palabra_regex	= /\A[a-z]+\z/i
  
  validates :ci_par, :numericality => true
  validates :nombre, :format => { :with => palabra_regex }
  validates :seg_nombre, :allow_blank => true,
                         :format => { :with => palabra_regex }
  validates :apellido, :format => { :with => palabra_regex }
  validates :seg_apellido, :allow_blank => true,
                           :format => { :with => palabra_regex }
  validates :telefono, :numericality => true,
                       :length => { :is => 11}
  validates :correo, :format => { :with => email_regex },
                     :uniqueness => { :case_sensitive => false }
  validates :direccion, :format => { :with => texto_regex }
  validates :institucion, :format => { :with => texto_regex }
	validates :nivel, :presence => true
end

