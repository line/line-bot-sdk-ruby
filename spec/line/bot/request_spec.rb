require 'spec_helper'

describe Line::Bot::Request do
  describe '#content_type' do
    subject { request.content_type }

    context 'content type is not specified' do
      let(:request) { described_class.new }

      it { is_expected.to eq 'application/json; charset=UTF-8' }
    end

    context 'content type is specified' do
      let(:request) do
        described_class.new do |config|
          config.content_type = 'application/x-www-form-urlencoded'
        end
      end

      it { is_expected.to eq 'application/x-www-form-urlencoded' }
    end

    context 'jpeg file is assigned' do
      let(:request) do
        described_class.new do |config|
          config.file = File.open('spec/fixtures/line/bot/preview.jpg')
        end
      end

      it { is_expected.to eq 'image/jpeg' }
    end

    context 'unsupported file is assigned' do
      let(:request) do
        described_class.new do |config|
          config.file = File.open('spec/fixtures/line/bot/video.mp4')
        end
      end

      it do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end
end
