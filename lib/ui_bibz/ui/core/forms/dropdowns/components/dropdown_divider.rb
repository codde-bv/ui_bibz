# frozen_string_literal: true

module UiBibz::Ui::Core::Forms::Dropdowns::Components
  # Create DropdownDivider
  #
  class DropdownDivider < UiBibz::Ui::Base
    # See UiBibz::Ui::Core::Component.initialize

    # Render html tag
    def pre_render
      content_tag :div, nil, class: 'dropdown-divider'
    end
  end
end
