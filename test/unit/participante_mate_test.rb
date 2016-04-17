# == Schema Information
#
# Table name: participantes_mates
#
#  id              :integer          not null, primary key
#  participante_id :integer          not null
#  material_pop_id :integer          not null
#  entregado       :boolean          default("0"), not null
#

require 'test_helper'

class ParticipanteMateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
