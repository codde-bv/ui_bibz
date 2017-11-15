require 'ui_bibz/ui/core/navigations/components/nav_link_link'
require 'ui_bibz/ui/core/navigations/components/nav_link_list'
module UiBibz::Ui::Core::Navigations

  # Create a NavLink
  #
  # This element is an extend of UiBibz::Ui::Core::Navigations::Component.
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
  # * +state+ - status of élement with symbol value:
  #   (+:active+)
  # * +url+ - String
  # * +badge+ - String
  # * +link_html_options+ - Hash
  #
  # ==== Signatures
  #
  #   UiBibz::Ui::Core::Navigations::NavLink.new(content, options = nil, html_options = nil)
  #
  #   UiBibz::Ui::Core::Navigations::NavLink.new(options = nil, html_options = nil) do
  #     content
  #   end
  #
  # ==== Examples
  #
  #   UiBibz::Ui::Core::Navigations::NavLink.new(content, { badge: 15, url: '/', state: :active, link_html_options: { class: 'link1' }},{ class: 'test' }).render
  #
  #   UiBibz::Ui::Core::Navigations::NavLink.new({glyph: { name: 'eye', size: 3 }, { class: 'test' }) do
  #     'Home'
  #   end.render
  #
  class NavLink < UiBibz::Ui::Core::Component

    # See UiBibz::Ui::Core::Component.initialize
    def initialize content = nil, options = nil, html_options = nil, &block
      super
    end

    # Render html tag
    def render
      content_htm = UiBibz::Ui::Core::Navigations::NavLinkLink.new(content, options, html_options).render
      if options[:nav_type] == "nav-links"
        content_htm
      else
        options.delete(:state)
        UiBibz::Ui::Core::Navigations::NavLinkList.new(content_htm, options).render
      end
    end

  end
end
