class Name
  def initialize(raw_name)
    @raw_name = raw_name
    @name = nil
    @sex = nil
    @title = nil
  end

  def to_s
    raw_name
  end

  def to_json
    parse_data
    {
      name: name,
      sex: sex.to_s.upcase,
      title: title
    }.to_json
  end

  def female?
    sex == :f
  end

  def male?
    sex == :m
  end

  private

  attr_reader :raw_name, :name, :sex, :title

  def parse_data
    return if name
    @name  = match[1]
    @sex   = match[2].downcase.to_sym
    @title = match[3]
  rescue NoMethodError
    puts '*'*20
    puts raw_name
    puts '*'*20
  end

  def match
    @match ||= raw_name.match(/\A(.+)\s+\(([fm])\)\s?\-?\s?(.*)\z/i)
  end
end
