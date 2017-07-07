require 'nokogiri'
require 'uri'
require 'open-uri'
require 'net/http'
require 'net/https'

require_relative 'game'
require_relative 'site'

class Selector
  TYPES = %w[unplayed for-fun playing].freeze

  def initialize(type = :unplayed, site = :default)
    @type = type
    @site = Site.select site
    @section = nil
    @error = nil
  end

  def random
    return unless parseable? && section
    games.sample
  end

  def all
    return [] unless parseable? && section
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

  attr_reader :type, :site

  def parseable?
    tags? || list?
  end

  def tags?
    html.include?("#{type}:start") && html.include?("#{type}:end")
  end

  def list?
    (html.include?('<li>') || html.include?('<li ')) && html.include?('</li>')
  end

  def games
    section.search('li').map(&:text).map { |g| Game.new g }
  end

  def section
    return @section if @section
    if tags?
      html.match(/<!--\s#{type}:start\s-->(.+)<!--\s#{type}:end\s-->/m).tap do |s|
        @section = Nokogiri::HTML(s[1]) if s
      end
    else
      @section = Nokogiri::HTML html
    end
  end

  def html
    @html ||= site_data
  end

  def site_data
    uri = URI.parse site

    http = Net::HTTP.new(uri.host, uri.port)
    if uri.scheme == 'https'
      http.use_ssl = true
      # possibly useful if you see ssl errors
      # http.verify_mode = ::OpenSSL::SSL::VERIFY_NONE
    end
    page = http.start { |session| session.get uri.request_uri }
    return page.body if page.body
    ''
  end
end
