# == Schema Information
#
# Table name: participantes_mesas
#
#  id                 :integer          not null, primary key
#  participante_id    :integer          not null
#  mesa_de_trabajo_id :integer          not null
#  seleccionado       :boolean          default("0"), not null
#  created_at         :datetime         not null
#  puesto             :integer
#

require 'test_helper'

class ParticipanteMesaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
