# == Schema Information
#
# Table name: ponencias
#
#  id              :integer          not null, primary key
#  titulo          :string(255)      not null
#  tema            :string(50)       not null
#  descripcion     :string(255)      not null
#  dia             :date             not null
#  hora_ini        :time             not null
#  hora_fin        :time             not null
#  requerimientos  :text(65535)      not null
#  ponente_id      :integer          not null
#  patrocinante_id :integer
#

require 'test_helper'

class PonenciaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
