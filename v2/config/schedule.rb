env :PATH, ENV['PATH']
set :output, { standard: 'config/standard.log', error: 'config/error.log' }

every 1.day, at: '10:00 am' do
  runner  'Birthday Notification'
  command 'sh /home/umeki/NotificationOnSlack/cron_script.sh'
end
