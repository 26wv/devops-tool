require 'sshkit'
require 'yaml'
require 'dotenv'
require 'logger'

Dotenv.load

module DevOpsTool
  SERVER_CONFIG = YAML.load_file('config/servers.yml')
  LOGGER = Logger.new('devops.log')

  def self.servers
    SERVER_CONFIG['servers'].map do |server|
      SSHKit::Host.new(
        hostname: server['hostname'],
        user: server['user'],
        password: server['password'],
        port: server['port'] || 22
      )
    end
  end
end