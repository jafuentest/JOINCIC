class MaterialPop < ActiveRecord::Base
  has_many :participantes_mates, :foreign_key => "id_mate"
  has_many :participantes, :through => :participante_mate, :foreign_key => "id_par"
  
  palabra_regex	= /\A[a-z]+\z/i
  
  validates :nombre,   :format => { :with => palabra_regex }
  validates :cantidad, :presence => true
end
