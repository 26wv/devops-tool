require 'sshkit/dsl'
require_relative '../devops_tool'

module DevOpsTool
  class Monitor
    def initialize(log_file)
      @log_file = log_file
    end

    def run
      on DevOpsTool.servers do |host|
        execute :tail, '-f', @log_file
      end
    end
  end
end