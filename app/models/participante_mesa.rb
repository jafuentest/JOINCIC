# == Schema Information
#
# Table name: participantes_mesas
#
#  id                 :integer          not null, primary key
#  participante_id    :integer          not null
#  mesa_de_trabajo_id :integer          not null
#  prioridad          :integer          not null
#  seleccionado       :boolean          default(FALSE), not null
#  created_at         :datetime         not null
#  puesto             :integer
#

class ParticipanteMesa < ActiveRecord::Base
  belongs_to :participante
  belongs_to :mesa_de_trabajo
end
