# == Schema Information
#
# Table name: rifas
#
#  id     :integer          not null, primary key
#  nombre :string(20)       not null
#

class Rifa < ActiveRecord::Base
  has_and_belongs_to_many :participantes
end
