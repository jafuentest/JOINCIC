# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Sistema::Application.initialize!

require "#{Rails.root}/app/overrides/all"