require 'spec_helper'

describe ThreadStrategy do
  let(:options) do
    {
      urls: %w(http://www.perl.com/ http://www.thecomic.com/ http://www.lunartik.com/),
      normal_interval: 30,
      emergency_interval: 60
    }
  end

  describe '#perform' do
    before do
      allow_any_instance_of(ThreadStrategy::Inspector).to receive(:inspect)
    end

    it 'creates thread for every url' do
      threads = described_class.new(options).perform
      expect(threads.size).to eq(3)
    end
  end
end
