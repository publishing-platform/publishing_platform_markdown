# frozen_string_literal: true

require "active_support"
require "active_support/core_ext/hash"
require "active_support/core_ext/array"
require "kramdown"
require "sanitize"

require_relative "publishing_platform_markdown/version"
require_relative "publishing_platform_markdown/html_sanitizer"

module PublishingPlatformMarkdown
  class Document
    def self.to_html(source, options = {})
      new(source, options).to_html
    end

    def initialize(source, options = {})
      options = options.dup.deep_symbolize_keys
      @source = source ? source.dup : ""

      @allowed_elements = options.delete(:allowed_elements) || []
      @options = { sanitize: true,
                   syntax_highlighter: nil }.merge(options)
    end

    def to_html
      @to_html ||= if @options[:sanitize]
                     HtmlSanitizer.new(kramdown_doc.to_html)
                                  .sanitize(allowed_elements: @allowed_elements)
                   else
                     kramdown_doc.to_html
                   end
    end

  private

    def kramdown_doc
      @kramdown_doc ||= Kramdown::Document.new(@source, @options)
    end
  end
end
