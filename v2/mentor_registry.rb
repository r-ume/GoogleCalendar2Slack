require 'yaml'
require 'pry'
require 'singleton'
require '../v2/mentor'

# List of Mentors
class MentorRegistry
  include Singleton
  MENTOR_CONFIG_FILENAME = 'mentors.yml'

  # Factory, setup registry
  # @return MentorRegistry
  def initialize
    @settings = YAML.load_file(MENTOR_CONFIG_FILENAME)
  end

  # Find mentors who has a specific name
  # @return Mentor
  def find_by_name(name)
    Mentor.new(@settings[name])
  end

end
