class ParticipanteMesa < ActiveRecord::Base
  belongs_to :participante,    :foreign_key => "id_par"
  belongs_to :mesa_de_trabajo, :foreign_key => "id_mesa"
end