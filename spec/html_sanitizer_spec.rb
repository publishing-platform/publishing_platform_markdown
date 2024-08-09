# frozen_string_literal: true

RSpec.describe PublishingPlatformMarkdown::HtmlSanitizer do
  describe "sanitize" do
    it "disallows script tag" do
      html = "<script>alert('XSS')</script>"
      expect(PublishingPlatformMarkdown::HtmlSanitizer.new(html).sanitize).to eql ""
    end
  end
end
