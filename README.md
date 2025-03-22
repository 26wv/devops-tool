[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
# DevOps Automation Tool

A Ruby-based CLI tool to automate DevOps tasks such as deployment, log monitoring, health checks, and server management. Built with `sshkit`, `thor`, and `slack-notifier`.

---

## Features

- **Remote Server Management**: Execute commands on remote servers via SSH.
- **Deployment Automation**: Deploy applications to remote servers.
- **Log Monitoring**: Tail and monitor logs in real-time.
- **Health Checks**: Perform health checks on servers and services.
- **Configuration Management**: Generate and upload configuration files using ERB templates.
- **Slack Notifications**: Send deployment status updates to Slack.
- **Docker Integration**: Automate Docker container deployment.

---

## Prerequisites

- Ruby 2.7 or higher
- Bundler (`gem install bundler`)
- Docker (optional, for Docker integration)
- Slack webhook URL (for notifications)

---

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/26wv/devops-tool.git
   cd devops-tool

2. Install dependencies:
    ```bash
    bundle install
3. Set up environment variables:
   - Create a .env file in the root directory.
   - Add the following variables (replace placeholders with actual values):
```env
SLACK_WEBHOOK_URL=https://hooks.slack.com/services/your/webhook/url
DEPLOY_USER=deploy
DEPLOY_PASSWORD=your_password
DEPLOY_HOST=example.com
DEPLOY_PORT=22
APP_NAME=my_app
```
---
## Usage
# Commands

1. Deploy an Application:
 ```bash
./bin/devops deploy my_app
```
- Pulls the latest code, installs dependencies, runs migrations, and restarts the application server.
- Generates and uploads configuration files (e.g., Nginx).

2. Monitor logs
```bash
./bin/devops monitor /var/log/my_app.log
```
- Tails the specified log file in real-time.
3. Perform health checks
```bash
./bin/devops health_check
```
- Checks server uptime and other health metrics.

---

## Configuration
# Server Configuration
Edit `config/servers.yml` to add your remote servers:

```yaml
Copy
servers:
  - hostname: 'example.com'
    user: 'deploy'
    password: 'password'
    port: 22
```

## Templates
Add ERB templates in the `templates/` directory. For example, `templates/nginx.conf.erb`:

```erb
Copy
server {
  listen 80;
  server_name <%= @app_name %>.example.com;

  location / {
    proxy_pass http://127.0.0.1:3000;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
  }
}
```
---
## Otgher Features
# Slack Notifications
- Notifications are sent to Slack for deployment success/failure.
- Set the `SLACK_WEBHOOK_URL` in `.env`.

Docker Integration

- Automate Docker container deployment by adding Docker commands to the `deploy` script.
- Ensure Docker is installed and running on your servers.

Error Handling and Logging
- Errors are logged to `devops.log`.
 Slack notifications include error details.

---

## I HATE RUBY 😡😡😡😡
