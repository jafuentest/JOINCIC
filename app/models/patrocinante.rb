class Patrocinante < ActiveRecord::Base
  belongs_to :plan_de_patrocinio
  has_many   :mesas_de_trabajo
  has_many   :ponencias
end
