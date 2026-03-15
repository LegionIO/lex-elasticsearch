# frozen_string_literal: true

module Legion
  module Extensions
    module Elasticsearch
      module Runners
        module Search
          def search(index:, query:, size: 10, from: 0, **)
            body = { query: query, size: size, from: from }
            resp = connection(**).post("#{index}/_search", body)
            hits = resp.body.dig('hits', 'hits') || []
            { total: resp.body.dig('hits', 'total', 'value'),
              hits:  hits.map { |h| { id: h['_id'], source: h['_source'], score: h['_score'] } } }
          end

          def count(index:, query: nil, **)
            body = query ? { query: query } : {}
            resp = connection(**).post("#{index}/_count", body)
            { count: resp.body['count'], index: index }
          end
        end
      end
    end
  end
end
