module UiBibz::Concerns::Models::Searchable
  extend ActiveSupport::Concern

  included do
    # Maybe create a class to put all methods of grid_search_pagination
    def self.grid_search_pagination params, session, args = {}
      @params     = params
      @session    = session
      @arguments  = args
      OpenStruct.new(records: search_sort_paginate,
                     model:      self,
                     controller: params[:controller],
                     direction:  params[:direction],
                     search:     params[:search],
                     sort:       params[:sort],
                     searchable_attributes: @searchable_attributes,
                     action:     params[:action])
    end


  private

    def self.search
      sql         = all
      column_args = get_column_args

      # Add joins
      sql = joins(column_args[:joins]) if column_args[:joins]

      # Append special argument for sort countable
      sql = generate_select_count_sort_query sql, column_args if column_args[:count]

      # Manage parent sort in the same model
      sql = generate_parent_sort_query sql if @params[:parent]

      # Main query with argument or not
      sql = search_by_query sql unless @params[:search].blank?

      # Select Count or Not
      if column_args[:count]
        sq = "SELECT * FROM (#{ sql.group(table_name + '.id').to_sql }) countable ORDER BY countable.count #{ @params[:direction] || asc }"
        self.paginate_by_sql(sq, :page => @params[:page], per_page: @session[:per_page])
      else
        sql.order(order_sql).paginate(:page => @params[:page], per_page: @session[:per_page])
      end

    end

    def self.generate_select_count_sort_query sql, column_args
      sql.select("#{ table_name }.*, count(#{ column_args[:column] }.*)")
    end

    def self.generate_parent_sort_query sql
      sql.select("#{ table_name }2.*, #{ @params[:sort] } AS parent_name").from("domains domains2").joins("LEFT OUTER JOIN #{ table_name } ON #{ table_name }2.parent_id = #{ table_name }.id")
    end

    def self.get_column_args
      column_args = {}
      if !@arguments[:sortable].nil? && @params[:custom_sort]
        column_args = [@arguments[:sortable]].flatten.detect{|f| f[:column] = @params[:column_name] } || {}
      end
      column_args
    end

    def self.search_by_query sql
      sql_query      = []
      sql_attributes = {}

      @searchable_attributes.each do |attribute|
        sql_query << "lower(#{ self.to_s.downcase.pluralize }.#{ attribute }) LIKE :#{ attribute }"
        sql_attributes = sql_attributes.merge(Hash[attribute, "%#{ @params[:search].downcase }%"])
      end

      sql.where([sql_query.join(' OR '), sql_attributes])
    end

    def self.order_sql
      @params[:sort].nil? || @params[:direction].nil? ? "#{ self.table_name }.id asc" : "#{ @params[:sort]} #{ @params[:direction] }"
    end

    def self.search_sort_paginate
      @session[:per_page] = @params[:per_page] unless @params[:per_page].nil?
      self.search
    end
  end

  module ClassMethods
    def searchable_attributes *args
      @searchable_attributes ||= args
    end
  end

end
