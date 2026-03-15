# frozen_string_literal: true

module Legion
  module Extensions
    module Elasticsearch
      module Runners
        module Documents
          def index_document(index:, body:, id: nil, **)
            path = id ? "#{index}/_doc/#{id}" : "#{index}/_doc"
            method = id ? :put : :post
            resp = connection(**).public_send(method, path, body)
            { result: resp.body['result'], id: resp.body['_id'], index: index }
          end

          def get_document(index:, id:, **)
            resp = connection(**).get("#{index}/_doc/#{id}")
            { found: resp.body['found'], source: resp.body['_source'], id: id, index: index }
          end

          def delete_document(index:, id:, **)
            resp = connection(**).delete("#{index}/_doc/#{id}")
            { result: resp.body['result'], id: id, index: index }
          end

          def update_document(index:, id:, body:, **)
            resp = connection(**).post("#{index}/_update/#{id}", { doc: body })
            { result: resp.body['result'], id: id, index: index }
          end
        end
      end
    end
  end
end
