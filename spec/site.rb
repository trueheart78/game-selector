require_relative 'spec_helper'
require_relative '../lib/site'

RSpec.describe Site do
  describe '.select' do
    subject { described_class.select site }

    context 'when the passed in site is batman' do
      it { is_expected.to eq url }

      let(:site) { :batman }
      let(:url)  { 'https://doggettck.github.io' }
    end

    context 'when the passed in site is not batman' do
      it { is_expected.to eq url }

      let(:site) { :butts }
      let(:url)  { 'http://blog.trueheart78.com/games/' }
    end
  end
end
