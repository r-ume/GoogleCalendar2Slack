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

  # Cron Job
  gem 'whenever'

  # ACTIVE SUPPORT
  gem 'activesupport'
end

group :development do
  # DEBUG
  gem 'pry'
  gem 'pry-byebug'
end
