source 'https://rubygems.org'

gem 'tripod'

# NOTE we have locked the rdf gem to 1.0.8 to prevent UTF-8 encoding
# bug.  We can unlock this once we have resolved this trello ticket in
# tripod: https://trello.com/c/6wbOZIEJ
gem 'rdf', '1.0.8'

gem 'rails', '3.2.13'
gem 'jquery-rails'
gem 'haml'
gem 'redcarpet'
gem 'mongoid'
gem 'devise'
gem 'simple_form'
gem 'mongoid-paperclip', require: 'mongoid_paperclip'
gem 'mongoid_slug'
gem 'activemodel', require: 'active_model'
gem 'country_select'
gem 'entypo-rails'
gem 'database_cleaner'
gem "sentry-raven", :git => "https://github.com/getsentry/raven-ruby.git", :branch => 'ead49c'
gem 'aws-sdk', '~> 1.3.4'
gem 'kaminari'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'yui-compressor' #requires java
end

group :development, :test do
  gem 'capistrano'
  gem 'rvm-capistrano'
  gem 'factory_girl_rails'
  gem 'rspec-rails', '~> 2.0'
  gem 'capybara'
  gem 'poltergeist'
  gem 'faker'
  gem 'launchy'
  gem 'email_spec'
  gem 'debugger'

end

group :development do
  gem 'guard'
  gem "rack-livereload"
  gem 'guard-livereload', require: false
end

group :test do
  gem 'rack_session_access'
end
