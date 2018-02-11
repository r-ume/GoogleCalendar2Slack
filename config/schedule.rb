env :PATH, ENV['PATH']
set :output, { error: 'cron/error.log' }

every 1.day, at: '09:00 pm' do
  command "cd #{File.join(File.expand_path('', Dir.pwd)} && sh cron_script.sh"
end
