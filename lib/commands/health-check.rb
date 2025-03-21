require 'sshkit/dsl'
require_relative '../devops_tool'

module DevOpsTool
  class HealthCheck
    def run
      on DevOpsTool.servers do |host|
        uptime = capture :uptime
        puts "Server: #{host.hostname}, Uptime: #{uptime}"
      end
    end
  end
end