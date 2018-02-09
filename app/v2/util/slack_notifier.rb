require 'rubygems'
require 'slack-notifier'
require 'dotenv'

Dotenv.load('../.env')

# Slack Notifier
class SlackNotifier
  @notifier = nil

  class << self

    # Makes slack notifier class instance variable.
    # @return nil
    def notifier
      @notifier ||= Slack::Notifier.new(ENV['TIMES_JIO_SLACK_WEBHOOK_URL'], username: 'TECH::CAMP WASEDA SHIFT REMINDER')
    end

    # Post the text on slack.
    # @return nil
    def post(text:)
      notifier.post(text: text)
    end
  end
end
