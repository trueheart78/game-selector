require_relative 'name'

class NameGenerator
  def initialize(sex = nil)
    @sex = sex.to_s[0] if sex
  end

  def random
    names.sample
  end

  private

  attr_reader :sex

  def names
    return all if sex.nil?
    return females if females?
    return males if males?
    []
  end

  def males?
    sex.upcase == 'M'
  end

  def females?
    sex.upcase == 'F'
  end

  def all
    females.concat males
  end

  def females
    [
      Name.new('Ashelia', 'F', 'Final Fantasy XII')
    ]
  end

  def males
    [
      Name.new('Ash', 'M', 'Evil Dead')
    ]
  end
end
