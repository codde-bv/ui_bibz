module UiBibz::Ui
  class Jumbotron < Component

    # Create a jumbotron
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
    # * +full_with+ - Boolean to render jumbotron in fullscreen
    #
    # ==== Signatures
    #
    #   UiBibz::Ui::Jumbotron.new(content, options = nil, html_options = nil)
    #
    #   UiBibz::Ui::Jumbotron.new(options = nil, html_options = nil) do
    #     content
    #   end
    #
    # ==== Examples
    #
    #   UiBibz::Ui::Jumbotron.new(content, full_width: true).render
    #
    #   UiBibz::Ui::Jumbotron.new() do
    #     #content
    #   end.render
    #
    def initialize content = nil, options = nil, html_options = nil, &block
      super
    end

    def render
      content_tag :div, class_and_html_options('jumbotron') do
        if full_width
          content_tag :div, @content, class: 'container'
        else
          @content
        end
      end
    end

  private

    def full_width
      @options[:full_width]
    end

  end
end
