require 'slack-notifier'

# Slack Notifier
class SlackNotifier
  @notifier = nil

  class << self
    def notifier
      @notifier ||= Slack::Notifier.new(ENV['TIMES_JIO_SLACK_WEBHOOK_URL'], username: 'TECH::CAMP WASEDA SHIFT REMINDER')
    end

    def post(text:)
      notifier.post(text: text)
    end
  end
end
