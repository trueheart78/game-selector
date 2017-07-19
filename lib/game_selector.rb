require_relative 'html'
require_relative 'site'
require_relative 'game'

class GameSelector
  TYPES = %w[unplayed for-fun playing].freeze

  def initialize(type = :unplayed, site = :default)
    @type = type
    @site = Site.select site
  end

  def random
    return if html.error?
    games.sample
  end

  def all
    return [] if html.error?
    games
  end

  private

  attr_reader :type, :site

  def games
    @games ||= html.items.map { |g| Game.new g }
  end

  def html
    @html ||= Html.new(site, type).content
  end
end
