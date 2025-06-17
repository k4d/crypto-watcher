# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.4.4'

# Core gems
gem 'httparty', '~> 0.21'     # HTTP client for API requests
gem 'json', '~> 2.6'          # JSON parsing
gem 'dotenv', '~> 2.8'        # Environment variable management
gem 'rake', '~> 13.0'         # Task runner

# Utility gems
gem 'activesupport', '~> 7.0' # Useful utilities and extensions
gem 'chronic', '~> 0.10'      # Natural language date parsing
gem 'colorize', '~> 0.8'      # Terminal output coloring
gem 'rufus-scheduler', '~> 3.9' # Scheduler for recurring tasks

group :development, :test do
  gem 'rspec', '~> 3.12'      # Testing framework
  gem 'pry', '~> 0.14'        # Debugging console
  gem 'rubocop', '~> 1.50'    # Code linting
  gem "rufo", "~> 0.18.1"     # Code formatting
  gem 'simplecov', '~> 0.22'  # Code coverage
end

group :development do
  gem 'guard', '~> 2.18'      # File watching for auto-testing
  gem 'guard-rspec', '~> 4.7' # Guard plugin for RSpec
  gem "guard-shell", "~> 0.7.2" # Shell command execution
end
