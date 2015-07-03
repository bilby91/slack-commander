require 'sinatra'
require 'octokit'
require 'yaml'
require 'logger'

require_relative 'lib/command'

class SlackCommander < Sinatra::Base
  set :bind, '0.0.0.0'

  configure do
    set :dump_errors, false
    set :show_exceptions, false
  end

  def validate_command!
    halt 403 unless params['token'] == ENV['SLACK_TOKEN']
  end

  post '/commands' do
    validate_command!

    command = params['command']

    Command.for(command)
      .new(params)
      .perform!

    [200, {}, "Your deployment started."]
  end

  error do
    [422, {}, env['sinatra.error'].message]
  end

end
