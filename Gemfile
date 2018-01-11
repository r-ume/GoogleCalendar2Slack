source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

group :production, :development do
  # FUNDAMENTAL
  gem 'dotenv'

  # GOOGLE API CLIENT
  gem 'google-api-client'

  # SLACK NOTIFICATION
  gem 'slack-notifier'

  # ENUM
  gem 'ruby-enum'  

  # Cron Job
  gem 'whenever'
end

group :development do
  # DEBUG
  gem 'pry'
  gem 'pry-byebug'
end
