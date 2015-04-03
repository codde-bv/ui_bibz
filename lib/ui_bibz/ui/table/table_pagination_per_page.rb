require "ui_bibz/ui/table/components/store"
module UiBibz::Ui
  class TablePaginationPerPage < Ui
    include WillPaginate::ActionView

    def initialize options = nil, html_options = nil
      @per_page_field = Component.new nil, options, html_options
    end

    def render
      if @per_page_field.options[:wrap_form] != false
        form_tag(url_for(controller: store.controller, action: store.action), method: :get) do
          per_page_html
        end
      else
        per_page_html
      end
    end

  private

    def store
      @store ||= if @per_page_field.options[:store].nil?
        raise 'Store is nil!'
      elsif @per_page_field.options[:store].try(:records).nil?
        raise 'Store can be created only with "table_search_pagination" method!'
      else
        Store.new @per_page_field.options.delete :store
      end
    end

    def per_page_html
      content_tag :div, class: 'table-pagination-per-page' do
        concat results_count_html
        concat UiBibz::Utils::Internationalization.new("ui_bibz.table.pagination.per_page", default: "Per page: ").translate
        concat select_tag('per_page', options_for_select([25, 50, 100], store.per_page), class: 'form-control')
      end
    end

    def results_count_html
      "#{ page_entries_info store.records } | ".html_safe
    end

    def from_current_results
      store.limit_value * store.current_page - store.limit_value + 1
    end

    def to_current_results
      store.limit_value * store.current_page
    end

  end
end
