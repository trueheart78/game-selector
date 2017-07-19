require 'uri'
require 'open-uri'
require 'net/http'
require 'net/https'

require_relative 'html_content'

class Html
  def initialize(url, type = nil)
    @url = url
    @type = type
    @content = nil
  end

  def content
    return @content if @content
    @content = HtmlContent.new page_content, type
  end

  private

  attr_reader :url, :type

  def page_content
    uri = URI.parse url

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
