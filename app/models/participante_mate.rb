# == Schema Information
#
# Table name: participantes_mates
#
#  id              :integer          not null, primary key
#  participante_id :integer          not null
#  material_pop_id :integer          not null
#  entregado       :boolean          default(FALSE), not null
#

class ParticipanteMate < ActiveRecord::Base
  belongs_to :participante
  belongs_to :material_pop
end
