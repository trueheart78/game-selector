require 'nokogiri'

class Selector
  def initialize(tag = :unplayed, file: nil)
    @tag = tag
    @file = file
    @section = nil
  end

  def random
    return unless tags? && section
    games.sample
  end

  def all
    return unless tags? && section
    games
  end

  private

  attr_reader :tag, :file

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
    @html ||= File.read(file) if file
  end
end
