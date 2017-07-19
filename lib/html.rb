require 'uri'
require 'open-uri'
require 'net/http'
require 'net/https'

class Html
  def initialize(url)
    @url = url
  end

  def content
    @content ||= page_content
  end

  def content?
    content != ''
  end

  private

  attr_reader :url

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
