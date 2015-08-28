require 'rubygems'
require 'bundler/setup'

require 'active_support/all'

# Load Sinatra Framework (with AR)
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/contrib/all' # Requires cookies, among other things

require 'pry'

require 'instagram'

APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))
APP_NAME = APP_ROOT.basename.to_s

# Sinatra configuration
configure do
  set :root, APP_ROOT.to_path
  set :server, :puma

  enable :sessions
  set :session_secret, ENV['SESSION_KEY'] || 'lighthouselabssecret'

  set :views, File.join(Sinatra::Application.root, "app", "views")
end

enable :sessions

# instagram-ruby-gem configuration
CALLBACK_URL = "http://localhost:3001/oauth/callback"
CLIENT_ID = "d119273d693948dea278436882eb2536"
CLIENT_SECRET = "e20f05e3f1eb45a9bd82d1db9ddf97e8"

Instagram.configure do |config|
  config.client_id = CLIENT_ID
  config.client_secret = CLIENT_SECRET
end

# Set up the database and models
require APP_ROOT.join('config', 'database')

# Load the routes / actions
require APP_ROOT.join('app', 'actions')


