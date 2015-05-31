class ParticipanteRifa < ActiveRecord::Base
	belongs_to :participante
  belongs_to :rifa
end
