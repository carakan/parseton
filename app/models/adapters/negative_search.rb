module Adapters
  class NegativeSearch
    REGX_SEARCH = /-([a-zA-Z]+)/
    REGX_VALIDATE = /-([a-zA-Z]+)/

    def NegativeSearch.match_scan(query)
      !query.scan(REGX_VALIDATE).empty?
    end

    def NegativeSearch.filter_results(data, query)
      words = query.scan(REGX_SEARCH).flatten.map{|result| result.gsub('-', '')}
      results = []
      data.each do |row|
        if search_in_row(row, words)
          results << row
        end
      end
      results
    end

    def NegativeSearch.update_query(query)
      query.gsub(REGX_SEARCH, '')
    end

    def NegativeSearch.search_in_row(row, words)
      words.all?{|word| !row['Name'].downcase.include?(word.downcase) &&
                        !row['Type'].downcase.include?(word.downcase) &&
                        !row['Designed by'].downcase.include?(word.downcase) }
    end
  end
end
