env :PATH, ENV['PATH']
set :output, { standard: 'cron/standard.log', error: 'cron/error.log' }

every 1.day, at: '09:00 pm' do
  command 'cd /Users/umeki/Desktop/Ruby/NotificationOnSlack && sh cron_script.sh'
end
