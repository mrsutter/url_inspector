require 'spec_helper'

describe FileParser do
  describe '#parse' do
    context 'when file contains non url string' do
      let(:file) { 'spec/fixtures/url_list_with_wrong_urls.txt' }

      it 'raises ArgumentError' do
        expect { described_class.new(file).parse }
          .to raise_error(ArgumentError)
      end
    end

    context 'when file is empty' do
      let(:file) { 'spec/fixtures/url_list_empty.txt' }

      it 'raises ArgumentError' do
        expect { described_class.new(file).parse }
          .to raise_error(ArgumentError)
      end
    end

    context 'when all file lines are urls' do
      let(:file) { 'spec/fixtures/url_list_correct.txt' }

      it 'returns unique urls' do
        urls = described_class.new(file).parse
        expect(urls)
          .to eq(['https://market.yandex.ru/', 'https://www.google.com'])
      end
    end
  end
end
