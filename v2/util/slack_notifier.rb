require 'slack-notifier'

# Slack Notifier
class SlackNotifier
  class << self
    def notifier_instance
      Slack::Notifier.new(ENV['TIMES_JIO_SLACK_WEBHOOK_URL'], username: 'TECH::CAMP WASEDA SHIFT REMINDER')
    end
  end
end
