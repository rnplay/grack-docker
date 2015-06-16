$:.unshift("/rails/app/models")

use Rack::ShowExceptions

require 'bundler/setup'
require 'active_record'
require 'grack'
require 'git_adapter'
require 'user'

use Rack::Auth::Basic, "Restricted git repository" do |username, password|
  username == User.find_by(email: username) || User.find_by(username: username)
end

config = {
  :project_root => "/var/repos",
  :adapter => Grack::GitAdapter,
  :git_path => '/usr/bin/git',
  :upload_pack => true,
  :receive_pack => true
}

run Grack::App.new(config)
