# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Reviews::Application.initialize!
YAML::ENGINE.yamler = 'syck'
