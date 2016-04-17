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

require 'test_helper'

class PreguntaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
