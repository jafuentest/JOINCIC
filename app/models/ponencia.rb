# == Schema Information
#
# Table name: ponencias
#
#  id              :integer          not null, primary key
#  titulo          :string(255)      not null
#  tema            :string(50)       not null
#  descripcion     :string(255)      not null
#  dia             :date             not null
#  hora_ini        :time             not null
#  hora_fin        :time             not null
#  requerimientos  :text(16777215)   default(""), not null
#  ponente_id      :integer          not null
#  patrocinante_id :integer
#

class Ponencia < ActiveRecord::Base
  belongs_to :ponente
  belongs_to :patrocinante
  has_many   :preguntas
  
  texto_regex   = /\A[a-z .,:;!¡¿?'"ÁÉÍÓÚÑáéíóúñ0123456789]+\z/i
  palabra_regex	= /\A[a-zÁÉÍÓÚÑáéíóúñ]+\z/i
  
  validates :titulo,         :format => { :with => texto_regex }
  validates :tema,           :format => { :with => texto_regex }
  validates :descripcion,    :format => { :with => texto_regex }
  validates :requerimientos, :format => { :with => texto_regex }
end
