# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Hs::Application.initialize!

$jlog = Logger.new("log/hs.log")
