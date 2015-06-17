$:.unshift("/rails/app/models")

use Rack::ShowExceptions

require 'bundler/setup'
require 'grack'

#conn = PG.connect( dbname: 'rnplay_production' )
#use Rack::Auth::Basic, "Restricted git repository" do |username, password|
#  
#end

class GitlabId

  def initialize(app)
    @app = app 
   end 

 def call(env)
   puts env.inspect
   env['GL_ID'] = ENV['REQUEST_URI'].split("/")[1]
   @app.call(env) 
 end 

end

use GitlabId

run Grack::Server.new({
	project_root: '/var/repos',
	upload_pack: true,
	receive_pack:true
})
