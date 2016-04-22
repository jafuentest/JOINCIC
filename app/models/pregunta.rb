# == Schema Information
#
# Table name: preguntas
#
#  id              :integer          not null, primary key
#  mensaje         :string(255)      not null
#  participante_id :integer          not null
#  ponencia_id     :integer          not null
#  aceptada        :boolean
#

class Pregunta < ActiveRecord::Base
  scope :aceptada, -> { where(aceptada: true) }

  belongs_to :participante
  belongs_to :ponencia

  self.include_root_in_json = true

  validates :mensaje,      presence: true, length: { maximum: 255 }

  validates :participante, presence: true
end
