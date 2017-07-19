class FakeHtmlContent
  attr_reader :content, :items

  def initialize(content: '', items: [])
    @content = content
    @items   = items
  end

  def error?
    return true if items.empty?
    false
  end
end
