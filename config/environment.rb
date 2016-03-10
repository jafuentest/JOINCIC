# Load the Rails application.
require File.expand_path('../application', __FILE__)

require "will_paginate"
require 'net/http'

# Variables de entorno #
# -------------------- #
SALT = "J0iNcIC"
ORGANIZADOR = 3
GRUPO = 2
PARTICIPANTE = 1

#Expresiones Regulares
EMAIL_REGEX   = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
TEXTO_REGEX   = /\A[a-z\d ÁÉÍÓÚÑáéíóúñ,.]+\z/i
LOGIN_REGEX   = /\A[a-z\d\-_]+\z/i

# Initialize the Rails application.
Rails.application.initialize!
