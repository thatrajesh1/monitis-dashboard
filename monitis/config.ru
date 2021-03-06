require 'dashing'
require 'ipaddr'

$config = YAML.load File.open("config.yml")
$config = $config[:dashing]

configure do
  set :auth_token, $config[:auth_token]
  set :protection, :except => :frame_options
  set :default_dashboard, 'monitis'

  helpers do
    def protected!
      end
    end
end

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

run Sinatra::Application
