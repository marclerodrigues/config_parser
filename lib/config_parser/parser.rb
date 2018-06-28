require "config_parser/config_line"

module ConfigParser
  class Parser
    attr_reader :file_path

    PARSE_DICTIONARY = {
      yes: true,
      true: true,
      on: true,
      no: false,
      off: false,
      false: false
    }.freeze

    def initialize(file_path:)
      @file_path = file_path
    end

    def perform
      {}.tap do |hash|
        lines_without_comments.each do |line|
          parsed = parse_line(line)
          hash[parsed.key] = parsed.value
        end
      end
    end

    private

    def parse_line(line)
      key, value = line.split("=").map(&:strip)
      parsed_value = PARSE_DICTIONARY.has_key?(value.to_sym) ? PARSE_DICTIONARY[value.to_sym] : value
      ConfigLine.new(key, parsed_value)
    end

    def lines_without_comments
      lines
        .delete_if { |line| line.start_with?("#") }
        .flat_map do |line|
          line.split("#").first
        end
    end

    def lines
      @_lines ||= IO.readlines(file_path)
    end
  end
end
