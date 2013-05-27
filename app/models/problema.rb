# == Schema Information
#
# Table name: problemas
#
#  id             :integer          not null, primary key
#  titulo         :string(255)
#  enunciado      :text
#  entradas       :text
#  salidas        :text
#  fin_de_entrega :datetime
#  created_at     :datetime
#  updated_at     :datetime
#

class Problema < ActiveRecord::Base
end
