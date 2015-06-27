$:.unshift("/rails/app/models")

use Rack::ShowExceptions

require 'bundler/setup'
require 'grack'

class GitAuthBasic < Rack::Auth::Basic

  def call(env)
    auth = Basic::Request.new(env)

    return unauthorized unless auth.provided?

    return bad_request unless auth.basic?

    repository_name = request.path.split("/").last.split(".").first

    if valid?(auth, repository_name)
      env['REMOTE_USER'] = auth.username
      return @app.call(env)
    end

    unauthorized
  end

   def valid?(auth, repository_name)
     @authenticator.call(repository_name, *auth.credentials)
   end

end

use GitAuthBasic, "Restricted rnplay.org git repository" do |repository_name, username, password|

  conn = PG.connect( dbname: 'rnplay_production', host: ENV['POSTGRES_PORT_5432_TCP_ADDR'], port: ENV['POSTGRES_PORT_5432_TCP_PORT'], user: "postgres", password: ENV['POSTGRES_PASSWORD'])

  conn.exec( "SELECT id from users inner join on apps.user_id = users.id where users.authentication_token = $1 and apps.url_token = $2", [username, repository_name]) do |result|
    result.each do |row|
    end
  end

end

run Grack::Server.new({
	project_root: '/var/repos',
	upload_pack: true,
	receive_pack:true
})
