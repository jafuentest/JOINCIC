class ParticipanteMesa < ActiveRecord::Base
  belongs_to :participante
  belongs_to :mesa_de_trabajo
end