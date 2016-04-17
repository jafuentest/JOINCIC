# == Schema Information
#
# Table name: problemas
#
#  id             :integer          not null, primary key
#  titulo         :string(255)
#  enunciado      :text(65535)
#  entradas       :text(65535)
#  salidas        :text(65535)
#  fin_de_entrega :datetime
#  updated_at     :datetime
#

require 'test_helper'

class ProblemaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
