require 'will_paginate'
require "will_paginate-bootstrap"
require "ui_bibz/ui/ux/table/components/store"
module UiBibz::Ui::Ux

  # Create a pagination for table
  #
  # ==== Attributes
  #
  # * +options+ - Options of element
  # * +html_options+ - Html Options of element
  #
  # ==== Options
  #
  # You can add HTML attributes using the +html_options+.
  # You can pass arguments in options attribute:
  # * +store+ - Store generate by '+table_search_pagination+' method
  #
  # ==== Signatures
  #
  #   UiBibz::Ui::Ux::TablePagination.new(store: @store)
  #
  # ==== Helper
  #
  #    table_pagination(options = {})
  #
  class TablePagination < UiBibz::Ui::Base
    include WillPaginate::ActionView

    # Initialize pagination with component item
    # pagination require WillPaginate gem
    def initialize options = nil, html_options = nil
      @pagination = UiBibz::Ui::Core::Component.new nil, options, html_options
    end

    # Render html tag with boostrap pagination theme
    def render
      will_paginate(store.records, params: store.parameters,  renderer: BootstrapPagination::Rails)
    end

  private


    # Store must be generated by *table_search_pagination* method
    def store
      @store ||= if @pagination.options[:store].nil?
        raise 'Store is nil!'
      elsif @pagination.options[:store].try(:records).nil?
        raise 'Store can be created only with "table_search_pagination" method!'
      else
        Store.new @pagination.options.delete :store
      end
    end

  end
end
