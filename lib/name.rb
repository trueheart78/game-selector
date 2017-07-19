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

  attr_reader :raw_name

  def name
    @name ||= raw_name.split('(').first.rstrip
  end

  def sex
    @sex ||= raw_name.split('(')[1].split(')').first.downcase.to_sym
  end

  def title
    @title ||= raw_name.split('-').last.lstrip
  end
end
