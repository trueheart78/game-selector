require 'uri'
require 'open-uri'
require 'net/http'
require 'net/https'

require_relative 'html_content'
require_relative 'redis_adapter'

class Html
  def initialize(url, type = nil)
    @url = url
    @type = type
    @content = nil
    @uri = nil
  end

  def content
    return @content if @content
    @content = HtmlContent.new page_content, type
  end

  private

  attr_reader :url, :type, :cached_body

  def page_content
    return cached_body if cached?
    download_page.tap { |body| cache body }
  end

  # possibly useful if you see ssl errors
  # http.verify_mode = ::OpenSSL::SSL::VERIFY_NONE
  def download_page
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == 'https'
    page = http.start { |session| session.get uri.request_uri }
    return page.body if page.body
    ''
  end

  def uri
    @uri ||= URI.parse url
  end

  def cached?
    @cached_body = redis.get redis_key
    !cached_body.nil?
  end

  def cache(content)
    return if content.nil? || content.empty?
    redis.setex redis_key, 600, content
  end

  def redis_key
    return "default_html:#{uri.host}" unless type
    "#{type}_html:#{uri.host}".to_sym
  end
end
