# frozen_string_literal: true

module PopoverExtension
  TOOLTIP_METHODS = %i[animation container delay html placement selector template title trigger
                       offset fallback_placement boundary sanitize white_list santitize_fn].freeze

  POPOVER_METHODS = %i[animation container content delay html placement selector template title
                       trigger offset fallback_placement boundary sanitize white_list sanitize_fn].freeze

  def popover_data_html
    unless options[:popover].blank?
      add_html_data :toggle, 'popover'
      add_html_data :content, (options[:popover].is_a?(String) ? options[:popover] : options[:popover][:content])
    end

    return unless options[:popover].is_a?(Hash)

    POPOVER_METHODS.each { |mth| add_html_data(mth, options[:popover].try(:[], mth)) unless options[:popover].try(:[], mth).nil? }
    add_html_data :placement, options[:popover].try(:[], :position) unless options[:popover].try(:[], :position).nil?
  end

  def tooltip_data_html
    return if options[:tooltip].nil?

    add_html_data :toggle, 'tooltip'

    if options[:tooltip].is_a?(Hash)
      TOOLTIP_METHODS.each { |mth| add_html_data(mth, options[:tooltip].try(:[], mth)) unless options[:tooltip].try(:[], mth).nil? }
      add_html_data :placement, options[:tooltip].try(:[], :position) unless options[:tooltip].try(:[], :position).nil?
    else
      add_html_data :title, options[:tooltip]
    end
  end
end
