require 'nokogiri'

class HtmlContent
  def initialize(content, type = nil)
    @content = content
    @type = type
    @section = nil
    @error = nil
  end

  def items
    return [] if error?
    section.search('li').map &:text
  end

  def error?
    return true if error
  end

  def error
    return 'No matching data found' unless valid?
    return @error if @error
    nil
  end

  private

  attr_reader :content, :type

  def valid?
    parseable? && section
  end

  def parseable?
    tags? || list?
  end

  def tags?
    return false unless type
    content.include?("#{type}:start") && content.include?("#{type}:end")
  end

  def list?
    (content.include?('<li>') || content.include?('<li ')) && content.include?('</li>')
  end

  def section
    return @section if @section
    if tags?
      content.match(/<!--\s#{type}:start\s-->(.+)<!--\s#{type}:end\s-->/m).tap do |s|
        @section = Nokogiri::HTML(s[1]) if s
      end
    else
      @section = Nokogiri::HTML content
    end
  end
end
