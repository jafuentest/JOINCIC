# == Schema Information
#
# Table name: premios
#
#  id              :integer          not null, primary key
#  nombre          :string(25)       not null
#  rifa_id         :integer          not null
#  participante_id :integer
#  patrocinante_id :integer
#

class Premio < ActiveRecord::Base
  belongs_to :rifa
  belongs_to :patrocinante
  belongs_to :participante
end
