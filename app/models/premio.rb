class Premio < ActiveRecord::Base
  belongs_to :rifa
  belongs_to :patrocinante
  belongs_to :participante
end
