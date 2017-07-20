require_relative 'html'
require_relative 'site'
require_relative 'name'

class NameSelector
  def initialize(sex = nil)
    @sex  = sex
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

  attr_reader :site, :sex

  def names
    @names ||= html.items.map { |n| Name.new n }.select { |n| n.sex? sex }
  end

  def html
    @html ||= Html.new(site, :characters).content
  end
end
