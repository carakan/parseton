module Adapters
  class ExactSearch
    REGX_SEARCH = /"([^"]*)"/
    REGX_VALIDATE = /"([^"]*)"/

    def ExactSearch.match_scan(query)
      !query.scan(REGX_VALIDATE).empty?
    end

    def ExactSearch.filter_results(data, query)
      words = query.scan(REGX_SEARCH).flatten.map{|result| result.gsub('"', '')}
      results = []
      data.each do |row|
        if search_in_row(row, words)
          results << row
        end
      end
      results
    end

    def ExactSearch.update_query(query)
      query.gsub(REGX_SEARCH, '')
    end

    def ExactSearch.search_in_row(row, words)
      words.all?{|word| row['Name'].downcase.include?(word.downcase) ||
                        row['Type'].downcase.include?(word.downcase) ||
                        row['Designed by'].downcase.include?(word.downcase) }
    end
  end
end
