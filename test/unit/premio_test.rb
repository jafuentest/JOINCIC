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

require 'test_helper'

class PremioTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
