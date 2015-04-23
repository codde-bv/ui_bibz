module UiBibz::Ui
  class Panel < Component

    # Create a panel
    #
    # ==== Attributes
    #
    # * +content+ - Content of element
    # * +options+ - Options of element
    # * +html_options+ - Html Options of element
    #
    # ==== Options
    #
    # You can add HTML attributes using the +html_options+.
    # You can pass arguments in options attribute:
    # * +state+ - State of élement with symbol value:
    #   (+:default+, +:primary+, +:info+, +:warning+, +:danger+)
    #
    # ==== Signatures
    #
    #   UiBibz::Ui::Alert.new(content, options = nil, html_options = nil)
    #
    #   UiBibz::Ui::Alert.new(options = nil, html_options = nil) do
    #     content
    #   end
    #
    #   UiBibz::Ui::Alert.new(options = nil, html_options = nil).tap do |p|
    #     p.header content = nil, options = nil, html_options = nil, &block
    #     p.body content = nil, options = nil, html_options = nil, &block
    #     p.footer content = nil, options = nil, html_options = nil, &block
    #   end
    #
    # ==== Examples
    #
    #   UiBibz::Ui::Panel('test').render
    #
    #   UiBibz::Ui::Panel(state: :primary) do |d|
    #     'test'
    #   end.render
    #
    #   UiBibz::Ui::Panel.new().tap do |p|
    #     p.header 'header', glyph: 'eye', class: 'header-test'
    #     p.body do
    #       'body'
    #     end
    #     p.footer 'footer'
    #   end.render
    #
    def initialize content = nil, options = nil, html_options = nil, &block
      super
    end

    # Header is a component element
    def header content = nil, options = nil, html_options = nil, &block
      @header = Component.new content, options, html_options, &block
    end

    # Body is a component element
    def body content = nil, options = nil, html_options = nil, &block
      @body = Component.new content, options, html_options, &block
    end

    # Footer is a component element
    def footer content = nil, options = nil, html_options = nil, &block
      @footer = Component.new content, options, html_options, &block
    end

    def render
      content_tag :div, class_and_html_options("panel") do
        concat(header_html) unless @header.nil?
        concat(body_html)   if !@body.nil? || !@content.nil?
        concat(footer_html) unless @footer.nil?
      end
    end

    def state
      sym = @options[:state] || :default
      "panel-#{ states[sym] }"
    end

  protected

    def header_html
      content_tag :div, @header.render, @header.class_and_html_options("panel-heading")
    end

    def body_html
      @body = Component.new @content unless @content.nil?
      content_tag :div, @body.render, @body.class_and_html_options("panel-body")
    end

    def footer_html
      content_tag :div, @footer.render, @footer.class_and_html_options("panel-footer")
    end

  end
end
