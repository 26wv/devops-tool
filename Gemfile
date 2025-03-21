# Gemfile

source 'https://rubygems.org'

# Core gems
gem 'thor', '~> 1.2' # For building the CLI interface
gem 'sshkit', '~> 1.21' # For executing commands on remote servers
gem 'net-ssh', '~> 6.1' # For SSH connections
gem 'dotenv-rails', '~> 2.7' # For managing environment variables

# Advanced features
gem 'slack-notifier', '~> 2.4' # For sending Slack notifications
gem 'erb', '~> 2.2' # For rendering configuration templates
gem 'yaml', '~> 0.1' # For parsing YAML configuration files

# Optional: Docker integration
gem 'docker-api', '~> 2.0' # For interacting with Docker (if needed)

# Development and testing gems
group :development do
  gem 'pry', '~> 0.14' # For debugging
  gem 'pry-byebug', '~> 3.10' # For step-by-step debugging
  gem 'rubocop', '~> 1.30' # For code linting
end

group :test do
  gem 'rspec', '~> 3.10' # For testing
  gem 'webmock', '~> 3.14' # For stubbing HTTP requests
end