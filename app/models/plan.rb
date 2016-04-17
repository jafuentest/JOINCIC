# == Schema Information
#
# Table name: planes
#
#  id         :integer          not null, primary key
#  nombre     :string(10)       not null
#  precio     :integer          not null
#  beneficios :text(65535)      not null
#

class Plan < ActiveRecord::Base
  has_many :patrocinantes
end
