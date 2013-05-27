# Load the rails application
require File.expand_path('../application', __FILE__)

require "will_paginate"

# Variables de entorno #
# -------------------- #
SALT = "J0iNcIC"
ORGANIZADOR = 3
GRUPO = 2
PARTICIPANTE = 1

#Expresiones Regulares
EMAIL_REGEX   = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
PALABRA_REGEX = /\A[a-zÁÉÍÓÚÑáéíóúñ]+\z/i
TEXTO_REGEX   = /\A[a-z\d ÁÉÍÓÚÑáéíóúñ,.]+\z/i
NOMBRES_REGEX = /\A[a-z ÁÉÍÓÚÑáéíóúñ]+[a-zÁÉÍÓÚÑáéíóúñ]+\z/i
LOGIN_REGEX   = /\A[a-z\d\-_]+\z/i

# Initialize the rails application
Sistema::Application.initialize!

