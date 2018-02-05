require 'yaml'
require 'pry'
require 'singleton'
require_relative './mentor'

# List of Mentors
class MentorRegistry
  include Singleton
  MENTOR_CONFIG_FILENAME = 'mentors.yml'

  # Factory, setup registry
  # @return MentorRegistry
  def initialize
    @settings = YAML.load_file("#{File.expand_path('')}/#{MENTOR_CONFIG_FILENAME}")
    @list = {}
  end

  # Find mentors who has a specific name
  # @return Mentor
  def find_by_name(name)
    @list[name] ||= Mentor.new(@settings[name])
  end

end
