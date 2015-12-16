module Adapters
  class SimpleSearch
    REGX_SEARCH = /([a-zA-Z]+)/
    REGX_VALIDATE = /[^\w\s]/

    def SimpleSearch.match_scan(query)
      query.scan(REGX_VALIDATE).empty?
    end

    def SimpleSearch.filter_results(data, query)
      words = query.scan(REGX_SEARCH).flatten
      results = []
      data.each do |row|
        if search_in_row(row, words)
          results << row
        end
      end
      results
    end

    def SimpleSearch.update_query(query)
      query.gsub(REGX_SEARCH, '')
    end

    def SimpleSearch.search_in_row(row, words)
      words.all?{|word| row['Name'].downcase.include?(word.downcase) ||
                        row['Type'].downcase.include?(word.downcase) ||
                        row['Designed by'].downcase.include?(word.downcase) }
    end
  end
end
