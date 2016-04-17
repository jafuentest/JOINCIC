# == Schema Information
#
# Table name: ponentes
#
#  id           :integer          not null, primary key
#  nombre       :string(15)       not null
#  apellido     :string(15)       not null
#  telefono     :string(11)       not null
#  correo       :string(50)       not null
#  institucion  :string(20)       not null
#  seg_nombre   :string(15)
#  seg_apellido :string(15)
#

require 'test_helper'

class PonenteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
