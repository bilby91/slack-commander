module Command

  require_relative 'command/deploy'

  class Error < StandardError; end

  AVAILABLE = {
    '/deploy' => Command::Deploy
  }

  def self.for(command)
    fail Error, "#{command} is not a valid command" unless AVAILABLE.key?(command)

    AVAILABLE[command]
  end

end
