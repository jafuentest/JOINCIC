class ParticipanteMate < ActiveRecord::Base
    belongs_to :participante
    belongs_to :material_pop
end
