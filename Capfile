# Load DSL and set up stages
require 'capistrano/setup'
require 'dotenv'

Dotenv.load

# Include default deployment tasks
require 'capistrano/deploy'

require 'capistrano/bundler'
require 'rvm1/capistrano3'
require 'capistrano/files'
require 'capistrano/nginx'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
