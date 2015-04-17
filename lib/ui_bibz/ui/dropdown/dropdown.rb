require 'ui_bibz/ui/dropdown/components/dropdown_list'
module UiBibz::Ui
  class Dropdown < Component

    # Create a dropdown
    #
    # ==== Signatures
    #
    #   UiBibz::Ui::Dropdown.new(name, state: :success).tap do |d|
    #     d.list link_to('test', '#')
    #     d.list link_to('test2', '#')
    #   end
    #
    def initialize content, options = nil, html_options  = nil, &block
      super
      @lists = []
      @state = @options.delete(:state)
    end

    def render
      content_tag :div, class_and_html_options(type) do
        concat button_html
        concat ul_html
      end
    end

    def list content = nil, options = nil, html_options = nil, &block
      @lists << DropdownList.new(content, options, html_options, &block).render
    end

  private

    def button_content
      [glyph_with_space, @content, ' ', caret].compact.join.html_safe
    end

    def button_html
      content_tag :button, button_content, class: add_classes("btn", button_state, size, "dropdown-toggle"), type: 'button', "data-toggle" => 'dropdown', "aria-expanded" => false
    end

    def ul_html
      content_tag :ul, @lists.join.html_safe, class: "dropdown-menu dropdown-menu-#{ position }", role: 'menu'
    end

    def caret
      content_tag :span, '', class: 'caret'
    end

    def position
      @options[:position] || 'left'
    end

    def type
      @options[:type] || 'dropdown'
    end

    def button_state
      sym = @state || :default
      "btn-#{  states[sym] }"
    end

    # :lg, :sm or :xs
    def size
      "btn-#{ @options[:size] }" if @options[:size]
    end

  end
end
