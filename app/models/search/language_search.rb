module Search
  class LanguageSearch
    include SimpleSearch

    def query(options = {})
      limit = options[:limit] || 100
      page = options[:page] || 1
      term = options[:q]

      dsl do
        size limit
        from (page - 1) * limit

        query do
          bool do
            should { match 'name.full'         => { query: term, operator: "and", type: 'phrase', boost: 5 } }
            should { match 'name.partial'      => { query: term, operator: "and", boost: 2 } }
            should { match 'full_name.full'    => { query: term, operator: "and", type: 'phrase', boost: 5 } }
            should { match 'full_name.partial' => { query: term, operator: "and", boost: 1 } }
          end
        end
      end
    end

  end
end
