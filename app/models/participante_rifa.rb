class ParticipanteRifa < ActiveRecord::Base
  self.table_name = 'participantes_rifas'
  belongs_to :participante
  belongs_to :rifa
end
