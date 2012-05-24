class Rifa < ActiveRecord::Base
  has_and_belongs_to_many :participantes
end
