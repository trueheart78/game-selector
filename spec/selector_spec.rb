require_relative 'spec_helper'
require 'byebug'
require_relative '../selector'

RSpec.describe Selector do
  subject { Selector.new :unplayed, file: fixture_file }

  describe '#random' do
    subject { Selector.new(:unplayed, file: fixture_file).random }

    it 'returns the proper hash' do
      expect(subject).to have_key :name
      expect(subject).to have_key :tags
    end
  end

  describe '#all' do
    subject { Selector.new(:unplayed, file: fixture_file).all }

    it 'lists all unplayed games' do
      expect(subject.size).to eq 23
    end
  end

  let(:fixture_file) do
    File.join Dir.pwd, 'spec', 'fixtures', 'sample.html'
  end
end
