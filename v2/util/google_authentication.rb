require 'rubygems'
require 'pry'
require 'fileutils'
require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'

class GoogleAuthentication
  SCOPE               = Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY
  OOB_URI             = 'urn:ietf:wg:oauth:2.0:oob'
  CLIENT_SECRETS_PATH = File.join(File.expand_path("..", Dir.pwd), 'client_secret.json')
  CREDENTIALS_PATH    = File.join(File.expand_path("..", Dir.pwd), '.credentials', 'calendar_ruby_sample_quickstart.yaml')

  class << self
    def access_to_calendar_service
      google_calendar               = Google::Apis::CalendarV3::CalendarService.new
      google_calendar.authorization = authorize
      google_calendar
    end

    def authorize
      FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))
      client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
      token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)
      authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
      user_id = 'default'
      credentials = authorizer.get_credentials(user_id)
      if credentials.nil?
        url = authorizer.get_authorization_url(base_url: OOB_URI)
        puts "Open the following URL in the browser and enter the " +
                 "resulting code after authorization"
        puts url
        code = gets
        credentials = authorizer.get_and_store_credentials_from_code(
            user_id: user_id, code: code, base_url: OOB_URI)
      end
      credentials
    end
  end

end
