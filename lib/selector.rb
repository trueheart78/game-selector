require 'nokogiri'
require 'open-uri'
require_relative 'game'

class Selector
  URL = 'http://blog.trueheart78.com/games/'.freeze
  TYPES = %w[unplayed for-fun].freeze

  def initialize(type = :unplayed)
    @type = type
    @section = nil
    @error = nil
  end

  def random
    return unless tags? && section
    games.sample
  end

  def all
    return [] unless tags? && section
    games
  end

  def error?
    return true if error
  end

  def error
    return 'No matching data found' unless tags? && section
    return @error if @error
    nil
  end

  private

  attr_reader :type

  def tags?
    html.include?("#{type}:start") && html.include?("#{type}:end")
  end

  def games
    section.search('li').map(&:text).map { |g| Game.new g }
  end

  def section
    return @section if @section
    html.match(/<!--\s#{type}:start\s-->(.+)<!--\s#{type}:end\s-->/m).tap do |s|
      @section = Nokogiri::HTML(s[1]) if s
    end
  end

  def html
    @html ||= File.read(open(URL))
  rescue OpenURI::HTTPError
    @html = ''
  end
end
