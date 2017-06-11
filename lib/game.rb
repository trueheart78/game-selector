class Game
  attr_reader :raw_name

  def initialize(raw_name)
    @raw_name = raw_name
    @name = nil
    @tags = nil
  end

  def name
    return @name if @name
    @name = raw_name.split('(').first.rstrip
  end

  def tags
    @tags ||= detect_tags
  end

  def to_s
    raw_name
  end

  private

  def detect_tags
    raw_name
      .gsub(') (', '|')
      .match(/.+\((.+)\)/)[1]
      .tr('/', '|')
      .split('|')
  end
end
