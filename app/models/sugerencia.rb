# == Schema Information
#
# Table name: sugerencias
#
#  id         :integer          not null, primary key
#  texto      :string(255)      not null
#  nombre     :string(30)
#  correo     :string(25)
#  created_at :datetime         not null
#

class Sugerencia < ActiveRecord::Base
end
