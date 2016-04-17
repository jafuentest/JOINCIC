# == Schema Information
#
# Table name: organizadores
#
#  id           :integer          not null, primary key
#  usuario      :string(15)       not null
#  clave        :string(15)       not null
#  nombre       :string(15)       not null
#  apellido     :string(15)       not null
#  correo       :string(50)       not null
#  institucion  :string(5)        not null
#  coordinacion :string(15)       not null
#  coordinador  :boolean          default("0"), not null
#  seg_nombre   :string(15)
#  seg_apellido :string(15)
#  eliminado    :boolean
#

require 'test_helper'

class OrganizadorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
