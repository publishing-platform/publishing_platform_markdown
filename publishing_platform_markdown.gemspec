# frozen_string_literal: true

require_relative "lib/publishing_platform_markdown/version"

Gem::Specification.new do |spec|
  spec.name = "publishing_platform_markdown"
  spec.version = PublishingPlatformMarkdown::VERSION
  spec.authors = ["Publishing Platform"]

  spec.summary = "Markup language for the Publishing Platform"
  spec.description = "Markup language for the Publishing Platform"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2"

  spec.files = Dir[
    "lib/**/*",
    "README.md",
    "Gemfile",
    "Rakefile",
  ]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = %w[lib]

  spec.add_dependency "kramdown", ">= 2.3.1", "< 2.5.2"
  spec.add_dependency "sanitize", ">= 6", "< 8"

  spec.add_development_dependency "publishing_platform_rubocop"
  spec.add_development_dependency "simplecov"
end
