# frozen_string_literal: true

module Legion
  module Extensions
    module Elasticsearch
      module Runners
        module Indices
          def list_indices(**)
            resp = connection(**).get('_cat/indices?format=json')
            { indices: resp.body }
          end

          def create_index(index:, settings: {}, mappings: {}, **)
            body = {}
            body[:settings] = settings unless settings.empty?
            body[:mappings] = mappings unless mappings.empty?
            resp = connection(**).put(index, body)
            { acknowledged: resp.body['acknowledged'], index: index }
          end

          def delete_index(index:, **)
            resp = connection(**).delete(index)
            { acknowledged: resp.body['acknowledged'], index: index }
          end

          def check_index(index:, **)
            resp = connection(**).head(index)
            { exists: resp.status == 200, index: index }
          end

          def get_index(index:, **)
            resp = connection(**).get(index)
            { index: index, data: resp.body }
          end
        end
      end
    end
  end
end
