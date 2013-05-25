# Load the rails application
require File.expand_path('../application', __FILE__)

require "will_paginate"

# Initialize the rails application
Sistema::Application.initialize!


# Variables de entorno #
# -------------------- #
SALT = "J0iNcIC"

#Expresiones Regulares
EMAIL_REGEX   = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
PALABRA_REGEX = /\A[a-z�?É�?ÓÚÑáéíóúñ]+\z/i
TEXTO_REGEX   = /\A[a-z\d �?É�?ÓÚÑáéíóúñ,.]+\z/i
NOMBRES_REGEX = /\A[a-z �?É�?ÓÚÑáéíóúñ]+[a-z�?É�?ÓÚÑáéíóúñ]+\z/i
LOGIN_REGEX   = /\A[a-z\d\-_]+\z/i
