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
#  updated_at     :datetime
#

class Problema < ActiveRecord::Base
  has_many :programas
end
