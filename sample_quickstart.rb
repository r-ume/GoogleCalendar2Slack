require 'rubygems'
require 'pry'
require 'fileutils'
require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'

SCOPE               = Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY
OOB_URI             = 'urn:ietf:wg:oauth:2.0:oob'
APPLICATION_NAME    = 'Google Calendar API Ruby Sample Quickstart'
CLIENT_SECRETS_PATH = 'client_secret.json'
CREDENTIALS_PATH    = File.join(Dir.pwd, '.credentials', 'calendar_ruby_sample_quickstart.yaml')

##
# Ensure valid credentials, either by restoring from the saved credentials
# files or intitiating an OAuth2 authorization. If authorization is required,
# the user's default browser will be launched to approve the request.
#
# @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials
def authorize
  FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))

  client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
  token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)
  authorizer = Google::Auth::UserAuthorizer.new(
      client_id, SCOPE, token_store)
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

# Initialize the API
service = Google::Apis::CalendarV3::CalendarService.new
service.client_options.application_name = APPLICATION_NAME
service.authorization = authorize

# Fetch the next 10 events for the user
calendar_id = 'primary'
response = service.list_events(calendar_id,
                               max_results: 10,
                               single_events: true,
                               order_by: 'startTime',
                               time_min: Time.now.iso8601)

puts "Upcoming events:"
puts "No upcoming events found" if response.items.empty?
calendar_events = response.items.map do |event|
  start = event.start.date || event.start.date_time
  p "#{event.summary} (#{start})"
end

File.open("response.txt", "w") do |f|
  f.puts(calendar_events)
end
