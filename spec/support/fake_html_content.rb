class FakeHtmlContent
  attr_reader :content, :items

  def initialize(content: '', items: [])
    @content = content
    @items   = items
  end

  def valid?
    return true unless items.empty?
    false
  end
end
