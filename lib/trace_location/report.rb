# frozen_string_literal: true

module TraceLocation
  module Report # :nodoc:
    require_relative 'generator'

    class InvalidFormatError < ArgumentError; end

    GENERATORS = {
      csv: ::TraceLocation::Generator::Csv,
      log: ::TraceLocation::Generator::Log,
      md: ::TraceLocation::Generator::Markdown,
      markdown: ::TraceLocation::Generator::Markdown,
      html: ::TraceLocation::Generator::Html
    }.freeze

    def self.build(events, return_value, options)
      resolve_generator(options[:format]).new(events, return_value, options)
    end

    def self.resolve_generator(format)
      format ||= TraceLocation.config.default_format
      GENERATORS.fetch(format) { raise InvalidFormatError }
    end
  end
end
