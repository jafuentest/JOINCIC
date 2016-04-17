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

class Problema < ActiveRecord::Base
  has_many :programas
end
