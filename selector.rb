require 'nokogiri'
require 'open-uri'

class Selector
  URL = 'http://blog.trueheart78.com/games/'

  def initialize(tag = :unplayed)
    @tag = tag
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

  attr_reader :tag

  def tags?
    html.include?("#{tag}:start") && html.include?("#{tag}:end")
  end

  def games
    section.search('li').map(&:text).map { |g| parse g }
  end

  def parse(name)
    game_tags = extract_tags name
    {
      name: game_name(name, game_tags),
      tags: game_tags.map(&:upcase)
    }
  end

  def game_name(name, game_tags)
    game_tags.each do |t|
      name.gsub! "(#{t})", ''
    end
    name.rstrip
  end

  def extract_tags(text)
    text.gsub(') (', '|').match(/.+\((.+)\)/)[1].split('|')
  end

  def section
    return @section if @section
    html.match(/<!--\s#{tag}:start\s-->(.+)<!--\s#{tag}:end\s-->/m).tap do |s|
      @section = Nokogiri::HTML(s[1]) if s
    end
  end

  def html
    @html ||= File.read(open(URL))
  rescue OpenURI::HTTPError
    @html = ''
  end
end
