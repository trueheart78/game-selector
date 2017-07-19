class Name
  attr_reader :name, :sex, :title

  def initialize(name, sex, title)
    @name  = name
    @sex   = sex
    @title = title
  end

  def to_s
    "#{name} (#{sex}) - #{title}"
  end
end
