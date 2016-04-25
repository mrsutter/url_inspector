module UrlInspector
  class FileParser
    attr_reader :file_name

    def initialize(file_name)
      @file_name = file_name
    end

    def parse
      urls = []

      File.readlines(file_name).each_with_index do |raw_line, index|
        url = raw_line.delete("\n")

        if valid_url?(url)
          urls << url
        else
          raise ArgumentError, "Please, check line##{index + 1} in your file"
        end
      end

      raise ArgumentError, "File doesn't have urls" if urls.empty?
      urls.uniq
    end

    private

    def valid_url?(url)
      uri = URI.parse(url)
      uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
    end
  end
end
