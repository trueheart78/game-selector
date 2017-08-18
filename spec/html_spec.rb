require_relative 'spec_helper'
require_relative '../lib/html'

RSpec.describe Html do
  include_context 'redis cleanup'

  describe '#content' do
    before  { stub_html_content }
    subject { described_class.new(url).content }

    context 'when the page is available' do
      before  { stub_url }

      it 'returns the html content object' do
        expect(subject).to eq html_content
      end
    end

    context 'when the page is not available' do
      before  { stub_url_failure }

      it 'returns the html content object' do
        expect(subject).to eq html_content
      end
    end

    let(:html_content) { FakeHtmlContent.new }
  end

  let(:url) { 'http://www.butts.com/games/' }

  def stub_html_content
    allow(HtmlContent).to receive(:new).and_return html_content
  end

  def stub_url
    stub_request(:get, url)
      .to_return status: 200, body: sample_fixture_data
  end

  def stub_url_failure
    stub_request(:get, url)
      .to_return status: 400
  end
end
