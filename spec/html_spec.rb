require_relative 'spec_helper'
require_relative '../lib/html'

RSpec.describe Html do
  describe '#content' do
  subject { described_class.new(url).content }

  context 'when the page is available' do
    before  { stub_url }

    it 'is the page html' do
      expect(subject).to_not eq ''
    end
  end

  context 'when the page is not available' do
    before  { stub_url_failure }

    it 'is an empty string' do
      expect(subject).to eq ''
    end
  end
  end

  describe '#content?' do
  subject { described_class.new(url).content? }

  context 'when the page is available' do
    before  { stub_url }

    it 'is true' do
      expect(subject).to eq true
    end
  end

  context 'when the page is not available' do
    before  { stub_url_failure }

    it 'is false' do
      expect(subject).to eq false
    end
  end
  end
  let(:fixture_file) do
    File.join Dir.pwd, 'spec', 'fixtures', 'sample.html'
  end
  let(:url) { 'http://www.butts.com/games/' }

  def stub_url
    stub_request(:get, url)
      .to_return status: 200, body: File.read(fixture_file)
  end

  def stub_url_failure
    stub_request(:get, url)
      .to_return status: 400
  end
end
