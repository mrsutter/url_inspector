require 'spec_helper'

describe ThreadPoolStrategy do
  let(:urls) do
    %w(http://www.perl.com/ http://www.thecomic.com/ http://www.lunartik.com/)
  end
  let(:options) do
    {
      urls: urls,
      normal_interval: 30,
      emergency_interval: 60
    }
  end

  before do
    Timecop.freeze
  end

  subject { ThreadPoolStrategy.new(options) }

  describe '#perform' do
    before do
      allow(subject).to receive(:loop).and_yield
      stub_request(:get, urls[0]).to_return(status: 200)
      stub_request(:get, urls[1]).to_return(status: 502)
      stub_request(:get, urls[2]).to_return(status: 200)
    end

    it 'creates thread for every url' do
      result = subject.perform
      expect(result[urls[0]]).to eq(Time.now + 30)
      expect(result[urls[1]]).to eq(Time.now + 60)
      expect(result[urls[2]]).to eq(Time.now + 30)
    end
  end

  after do
    Timecop.return
  end
end
