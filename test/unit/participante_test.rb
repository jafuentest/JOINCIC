# == Schema Information
#
# Table name: participantes
#
#  id                 :integer          not null, primary key
#  cedula             :integer          not null
#  nombre             :string(15)       not null
#  apellido           :string(15)       not null
#  fecha_nac          :date             not null
#  telefono           :string(11)       not null
#  correo             :string(50)       not null
#  direccion          :string(50)       not null
#  institucion        :string(20)       not null
#  nivel              :integer          not null
#  tipo_nivel         :string(9)        not null
#  zona_id            :integer          not null
#  entrada            :integer          not null
#  comida             :boolean          default("0"), not null
#  eliminado          :boolean          default("0"), not null
#  created_at         :datetime         not null
#  seg_nombre         :string(15)
#  seg_apellido       :string(15)
#  deposito           :integer
#  grupo_id           :integer
#  carrera            :string(255)
#  esEstudiante       :boolean
#  interesadoPasantia :boolean
#  periodoPasantia    :string(255)
#  intereses          :string(255)
#  experiencia        :string(255)
#  organizador_id     :integer
#  nacionalidad       :string(255)
#

require 'test_helper'

class ParticipanteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
