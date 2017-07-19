require_relative 'html'
require_relative 'site'
require_relative 'game'

class Selector
  TYPES = %w[unplayed for-fun playing].freeze

  def initialize(type = :unplayed, site = :default)
    @type = type
    @site = Site.select site
    @section = nil
    @error = nil
  end

  def random
    return unless html.valid?
    games.sample
  end

  def all
    return [] unless html.valid?
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
