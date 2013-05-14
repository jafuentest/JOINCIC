# == Schema Information
#
# Table name: planes
#
#  id         :integer          not null, primary key
#  nombre     :string(10)       not null
#  precio     :integer          not null
#  beneficios :text             default(""), not null
#

class Plan < ActiveRecord::Base
  has_many :planes
end
