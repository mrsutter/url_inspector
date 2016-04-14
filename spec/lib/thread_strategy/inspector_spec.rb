require 'spec_helper'

describe ThreadStrategy::Inspector do
  let(:options) do
    {
      url: 'http://www.google.com/',
      normal_interval: 1,
      emergency_interval: 3
    }
  end

  subject { ThreadStrategy::Inspector.new(options) }

  before do
    UrlInspectorLogger.new('/dev/null')
    allow(subject).to receive(:loop).and_yield
  end

  describe '#inspect' do
    context 'when response is 200' do
      before do
        stub_request(:get, options[:url]).to_return(status: 200)
      end

      it "doesn't change request interval" do
        expect { subject.inspect }.not_to change { subject.interval }
      end
    end

    context 'when response is 403' do
      before do
        stub_request(:get, options[:url]).to_return(status: 403)
      end

      it 'changes request interval from normal to emergency' do
        expect { subject.inspect }
          .to change { subject.interval }
          .from(options[:normal_interval])
          .to(options[:emergency_interval])
      end
    end
  end
end
