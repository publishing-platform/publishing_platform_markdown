class PublishingPlatformMarkdown::HtmlSanitizer
  def initialize(dirty_html, options = {})
    @dirty_html = dirty_html
  end

  def sanitize(allowed_elements: [])
    Sanitize.fragment(@dirty_html, sanitize_config(allowed_elements:))
  end  

  def sanitize_config(allowed_elements: [])
    # We purposefully disable style elements which Sanitize::Config::RELAXED allows
    elements = Sanitize::Config::RELAXED[:elements] - %w[style] +
      %w[svg path].concat(allowed_elements)

    Sanitize::Config.merge(
      Sanitize::Config::RELAXED,
      elements:,
      attributes: {
        # We purposefully disable style attributes which Sanitize::Config::RELAXED allows
        :all => Sanitize::Config::RELAXED[:attributes][:all] + %w[role aria-label] - %w[style],
        "a" => Sanitize::Config::RELAXED[:attributes]["a"] + [:data] + %w[draggable],
        "svg" => %w[xmlns width height viewbox focusable],
        "path" => %w[fill d],
        "div" => [:data],
        # The style attributes are permitted here just for the ones Kramdown for table alignment
        # we replace them in a post processor.
        "th" => Sanitize::Config::RELAXED[:attributes]["th"] + %w[style],
        "td" => Sanitize::Config::RELAXED[:attributes]["td"] + %w[style],
      },
      # The only styling we permit is text-align on table cells (which is the CSS kramdown
      # generates), we can therefore only allow this one CSS property
      css: { properties: %w[text-align] },
    )
  end
end