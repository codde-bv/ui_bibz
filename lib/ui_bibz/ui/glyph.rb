module UiBibz::Ui

  # Create a glyph
  #
  # This element is an extend of UiBibz::Ui::Component.
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
  # * +name+ - String
  # * +size+ - Integer
  # * +type+ - Symbol
  #
  # ==== Signatures
  #
  #   UiBibz::Ui::Glyph.new content = nil, options = nil, html_options = nil,
  #   &block
  #
  #   UiBibz::Ui::Glyph.new(options = nil, html_options = nil) do
  #     content
  #   end
  #
  #   UiBibz::Ui::Glyph.new content = {}
  #
  #   UiBibz::Ui::Glyph.new content, options = {}, html_options = {}
  #
  # ==== Exemples
  #
  #   UiBibz::Ui::Glyph.new('eye').render
  #
  #   UiBibz::Ui::Glyph.new() do
  #     name
  #   end.render
  #
  #   UiBibz::Ui::Glyph.new('eye', { size: 3, type: 'fw' }).render
  #
  #   UiBibz::Ui::Glyph.new({ name: 'eye', size: 3, type: 'fw' }).render
  #
  #
  class Glyph < Component

    def initialize content, options = nil, html_options = nil, &block
      super
    end

    def render
      content_tag :i, '', class_and_html_options(classes)
    end

    def classes
      cls = ["glyph", "fa", "fa-#{ content }"]
      cls << "fa-#{ size }x"         unless size.nil?
      cls << "fa-rotate-#{ rotate }" unless rotate.nil?
      cls << "fa-flip-#{ flip }"     unless flip.nil?
      cls << "fa-stack-#{ stack }x"  unless stack.nil?
      cls << "fa-#{ type }"          unless type.nil?
      cls.compact.join(' ')
    end

    def size
      @options[:size]
    end

    def stack
      @options[:stack]
    end

    def rotate
      @options[:rotate]
    end

    def flip
      @options[:flip]
    end

    def type
      @options[:type]
    end

    def content
      @options[:name] || @content
    end

  end
end
