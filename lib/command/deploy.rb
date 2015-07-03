class Command::Deploy

  attr_reader :ref, :env, :app, :user, :payload

  def initialize(payload)
    fail ::Command::Error, "The /deploy command uses the syntax [app]@[branch]@[env]" unless payload.key?('text')

    @app, @ref, @env = payload['text'].split('@')
    @user = payload['user_name']
    @payload = payload
  end

  def perform!
    fail ::Command::Error, "No deployment configured for #{@app}" unless config.key?(@app)
    fail ::Command::Error, "You are not allow to make deployments" unless config[@app]['deploy_users'].include? @user

    data = { environment: @env, payload: app_data.merge({
      notify: {
        user: @user,
        room: ENV['SLACK_CHANNEL']
      }})
    }

    github_client.create_deployment(repo, @ref, data)
  end

  def config
    @deploys_config ||= YAML::load_file(File.join(__dir__, '../../config/heaven.yml'))
  end

  def app_data
    config[@app]['data']
  end

  def repo
    "#{github_team}/#{@app}"
  end

  def github_team
    ENV['GITHUB_TEAM']
  end

  def github_client
    @client ||= Octokit::Client.new(access_token: ENV['GITHUB_ACCESS_TOKEN'])
  end

end
