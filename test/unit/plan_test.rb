# == Schema Information
#
# Table name: planes
#
#  id         :integer          not null, primary key
#  nombre     :string(10)       not null
#  precio     :integer          not null
#  beneficios :text(65535)      not null
#

require 'test_helper'

class PlanTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
