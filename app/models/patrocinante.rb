# == Schema Information
#
# Table name: patrocinantes
#
#  id         :integer          not null, primary key
#  rif        :string(12)       not null
#  nombre     :string(30)       not null
#  aporte     :integer          not null
#  plan_id    :integer          not null
#  comentario :text(65535)
#  logo       :binary(65535)
#

class Patrocinante < ActiveRecord::Base
  belongs_to :plan
  has_many   :mesas_de_trabajo
  has_many   :ponencias
end
