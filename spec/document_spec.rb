# frozen_string_literal: true

RSpec.describe PublishingPlatformMarkdown::Document do
  describe "#to_html" do
    it "renders markdown as html" do
      rendered = PublishingPlatformMarkdown::Document.new("*this is markdown*").to_html
      expect(rendered).to eql "<p><em>this is markdown</em></p>\n"
    end

    it "renders markdown as html using simplified API" do
      rendered = PublishingPlatformMarkdown::Document.to_html("*this is markdown*")
      expect(rendered).to eql "<p><em>this is markdown</em></p>\n"
    end
  end
end
