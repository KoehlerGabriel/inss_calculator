source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.1"

# Core Rails gems
gem "rails", "~> 7.0.7"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "sprockets-rails"
gem "bootsnap", require: false

# JavaScript & CSS
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"

# Views and JSON
gem "jbuilder"

# Time Zone support
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Utilities
gem "chartkick"
gem "groupdate"
gem "simple_form"
gem "devise"
gem "kaminari"
gem "faker"

# Development & Test gems
group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "rspec-rails", "~> 6.0"
  gem "factory_bot_rails"
  gem "shoulda-matchers", "~> 5.0"
  gem "rails-controller-testing"
end

# Development-specific gems
group :development do
  gem "web-console"
end

# Test-specific gems
group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
