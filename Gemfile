source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2', '>= 6.0.2.2'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'

gem 'devise', '~> 4.7.1'
gem 'fast_jsonapi'
gem 'friendly_id', '~> 5.2.4'
gem 'jwt'
gem 'oj'
gem 'versionist'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'

  gem 'guard', '~> 2.16.1'
  gem 'guard-brakeman', '~> 0.8.6', require: false
  gem 'guard-reek', '~> 1.2.0', require: false
  gem 'guard-rubocop', '~> 1.3.0', require: false

  gem 'brakeman', '~> 4.8.0', require: false
  gem 'bullet', '~> 6.1.0'
  gem 'reek', '~> 5.6.0', require: false
  gem 'rubocop', '~> 0.80.1', require: false
  gem 'rubocop-rails', '~> 2.4.2', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
