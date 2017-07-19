def fixture(name)
  File.join Dir.pwd, 'spec', 'fixtures', "#{name}.html"
end

def fixture_data(name)
  File.read fixture(name)
end

def sample_fixture_data
  fixture_data :sample
end
