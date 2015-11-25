source 'https://rubygems.org'

ruby "2.2.3"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', group: :development
gem 'awesome_rails_console'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass', '~> 3.3.4'
gem 'semantic-ui-sass', github: 'doabit/semantic-ui-sass'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'momentjs-rails', '~> 2.9',  :github => 'derekprior/momentjs-rails'
gem 'datetimepicker-rails', github: 'zpaulovics/datetimepicker-rails', branch: 'master', submodules: true
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'slim'
gem "slim-rails"
gem "haml-rails", "~> 0.9"
gem 'simple_form'

gem 'roo', '~> 2.0.0'
gem 'roo-xls'

gem 'will_paginate-bootstrap'

gem "font-awesome-rails"

gem "ransack"

gem "cocoon"

gem 'aasm'

gem 'rails-i18n', github: 'svenfuchs/rails-i18n', branch: 'master'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'quiet_assets'
  gem "bullet"
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem "better_errors"
  gem "binding_of_caller"
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
  gem 'puma'
end
