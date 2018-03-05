require_relative 'spec_helper'
require_relative '../lib/html'

RSpec.describe Html do
  include_context 'redis cleanup'

  describe '#content' do
    before  { stub_html_content }
    subject { described_class.new(url).content }

    context 'when the page is available' do
      before  { stub_url }

      it 'calls the url' do
        subject
        expect(stub_url).to have_been_requested
      end

      it 'returns the html content object' do
        expect(subject).to eq html_content
      end
    end

    context 'when the page is not available' do
      before  { stub_url_failure }

      it 'calls the url' do
        subject
        expect(stub_url).to have_been_requested
      end

      it 'returns the html content object' do
        expect(subject).to eq html_content
      end
    end

    context 'when the page redirects' do
      context 'with a 301' do
        before do
          stub_url_redirect code: 301
          stub_redirect_url
        end

        it 'calls the redirect url' do
          subject
          expect(stub_redirect_url).to have_been_requested
        end

        it 'returns the html content object' do
          expect(subject).to eq html_content
        end
      end

      context 'with a 302' do
        before do
          stub_url_redirect code: 302
          stub_redirect_url
        end

        it 'calls the redirect url' do
          subject
          expect(stub_redirect_url).to have_been_requested
        end

        it 'returns the html content object' do
          expect(subject).to eq html_content
        end
      end
    end

    let(:html_content) { FakeHtmlContent.new }
  end

  let(:url)          { 'http://www.butts.com/games/' }
  let(:redirect_url) { 'http://butts.com/games/' }

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

  def stub_url_redirect(code: 301)
    stub_request(:get, url)
      .to_return status: code, headers: { 'Location' => redirect_url }
  end

  def stub_redirect_url
    stub_request(:get, redirect_url)
      .to_return status: 200, body: sample_fixture_data
  end
end
