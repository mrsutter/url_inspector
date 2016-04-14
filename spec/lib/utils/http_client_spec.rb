require 'spec_helper'

describe HttpClient do
  let(:url) { 'http://www.google.com' }

  def stub_reqest_and_return_status(status)
    stub_request(:get, url).to_return(status: status)
  end

  subject { HttpClient }

  describe '.call' do
    context 'when response status is success or redirection' do
      it 'returns valid http_response object when status is 200' do
        stub_reqest_and_return_status(200)

        result = subject.get(url)

        expect(result).to be_an_instance_of(HttpClient::Response)
        expect(result.success?).to eq(true)
      end

      it 'returns valid http_response object when status is 301' do
        stub_reqest_and_return_status(301)

        result = subject.get(url)

        expect(result).to be_an_instance_of(HttpClient::Response)
        expect(result.success?).to eq(true)
      end
    end

    context 'when response status is client/server error' do
      it 'returns valid http_response object when status is 401' do
        stub_reqest_and_return_status(401)

        result = subject.get(url)

        expect(result).to be_an_instance_of(HttpClient::Response)
        expect(result.success?).to eq(false)
      end

      it 'returns valid http_response object when status is 500' do
        stub_reqest_and_return_status(500)

        result = subject.get(url)

        expect(result).to be_an_instance_of(HttpClient::Response)
        expect(result.success?).to eq(false)
      end
    end
  end
end
