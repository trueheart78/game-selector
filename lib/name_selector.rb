require_relative 'html'
require_relative 'site'
require_relative 'name'

class NameSelector
  def initialize
    @site = Site.select :characters
  end

  def random
    return if html.error?
    names.sample
  end

  def all
    return [] if html.error?
    names
  end

  private

  attr_reader :site

  def names
    @names ||= html.items.map { |n| Name.new n }
  end

  def html
    @html ||= Html.new(site, :character).content
  end
end
