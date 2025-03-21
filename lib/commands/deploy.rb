require 'sshkit/dsl'
require 'erb'
require 'slack-notifier'
require_relative '../devops_tool'

module DevOpsTool
  class Deploy
    def initialize(app_name)
      @app_name = app_name
      @notifier = Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL'])
    end

    # Generate configuration files from ERB templates
    def generate_config(template_path, output_path, binding)
      template = File.read(template_path)
      rendered = ERB.new(template).result(binding)
      File.write(output_path, rendered)
    end

    # Run the deployment process
    def run
      begin
        on DevOpsTool.servers do |host|
          DevOpsTool::LOGGER.info("Starting deployment of #{@app_name} on #{host.hostname}")

          within "/var/www/#{@app_name}" do
            # Step 1: Generate Nginx configuration from template
            generate_config(
              'templates/nginx.conf.erb',
              'nginx.conf',
              binding
            )

            # Step 2: Upload Nginx configuration to the server
            upload! 'nginx.conf', "/etc/nginx/sites-available/#{@app_name}.conf"
            execute :sudo, :ln, '-sf', "/etc/nginx/sites-available/#{@app_name}.conf", "/etc/nginx/sites-enabled/#{@app_name}.conf"
            execute :sudo, :systemctl, :reload, :nginx

            # Step 3: Pull the latest code from Git
            execute :git, :pull, :origin, :main

            # Step 4: Install dependencies
            execute :bundle, :install

            # Step 5: Run database migrations
            execute :rails, :db:migrate

            # Step 6: Restart the application server
            execute :sudo, :systemctl, :restart, :puma

            # Step 7: Docker deployment (optional)
            execute :docker, :build, '-t', @app_name, '.'
            execute :docker, :stop, @app_name, raise_on_non_zero_exit: false
            execute :docker, :rm, @app_name, raise_on_non_zero_exit: false
            execute :docker, :run, '-d', '--name', @app_name, '-p', '3000:3000', @app_name
          end
        end

        # Notify Slack about successful deployment
        @notifier.ping("✅ Deployment of #{@app_name} completed successfully!")
        DevOpsTool::LOGGER.info("Deployment of #{@app_name} completed successfully!")
      rescue => e
        # Notify Slack about deployment failure
        @notifier.ping("❌ Deployment of #{@app_name} failed: #{e.message}")
        DevOpsTool::LOGGER.error("Deployment of #{@app_name} failed: #{e.message}")
        raise e
      end
    end
  end
end