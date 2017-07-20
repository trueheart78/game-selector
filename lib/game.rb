class Game
  attr_reader :raw_name

  def initialize(raw_name)
    @raw_name = raw_name
    @title = nil
    @tags = nil
  end

  def title
    return @title if @title
    @title = raw_name.split('(').first.rstrip
  end

  def tags
    @tags ||= detect_tags
  end

  def to_s
    raw_name
  end

  def to_json
    {
      game:   raw_name,
      title:  title,
      tags:   tags
    }.to_json
  end

  private

  def tags?
    raw_name.include?('(') && raw_name.include?(')')
  end

  def detect_tags
    return [] unless tags?
    raw_name
      .gsub(') (', '|')
      .match(/.+\((.+)\)/)[1]
      .tr('/', '|')
      .split('|')
  end
end
