class Search
  attr_accessor :query, :results

  SOURCE_JSON = Rails.root.join('public', 'data.json')

  TYPE_SEARCH = [
                  ::Adapters::SimpleSearch,
                  ::Adapters::ExactSearch,
                  ::Adapters::NegativeSearch
                ]

  # Constructor of this class
  def initialize(query)
    if query.is_a?(String)
      @query = query
    else
      @query = ""
    end
    @results = nil
  end

  # process the data
  def process
    @query = sanitize_results
    if !@query.blank?
      TYPE_SEARCH.each do |searcher|
        if searcher.match_scan(query)
          @results = searcher.filter_results(repo_data, query)
          @query = searcher.update_query(query)
          process
        end
      end
    end
  end

  # this method clean the patner
  def sanitize_results
    @query = @query.strip
  end

  # method for extract initial values for search
  def repo_data
    if @results.nil?
      @results = JSON.parse(SOURCE_JSON.read)
    end
    @results
  end
end
