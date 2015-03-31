require 'ui_bibz/ui/table/components/columns'
require 'ui_bibz/ui/table/components/column'
module UiBibz::Ui
  class Store

    attr_accessor :records

    def initialize store
      @records = store.records
      @store   = store
      @model   = store.model
    end

    def total_pages
      @records.total_pages
    end

    def per_page
      @records.per_page
    end

    def total_entries
      @records.total_entries
    end

    def sort
      @store.sort
    end

    def direction
      @store.direction
    end

    def searchable_attributes
      @store.searchable_attributes
    end

    def current_page
      @records.current_page
    end

    def limit_value
      @records.limit_value
    end

    def columns
      @columns ||= Columns.new model.new.attributes.keys.map{ |record| Column.new({ data_index: record, name: record.humanize }) }
    end

    def model
      @model
    end

    def search
      @store.search
    end

    def controller
      @store.controller
    end

    def action
      @store.action
    end

  end
end
