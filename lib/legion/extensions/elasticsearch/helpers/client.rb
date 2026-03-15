# frozen_string_literal: true

require 'faraday'

module Legion
  module Extensions
    module Elasticsearch
      module Helpers
        module Client
          def connection(url: 'http://127.0.0.1:9200', api_key: nil, **)
            Faraday.new(url: url) do |conn|
              conn.request :json
              conn.response :json, content_type: /\bjson$/
              conn.headers['Authorization'] = "ApiKey #{api_key}" if api_key
              conn.headers['Content-Type'] = 'application/json'
              conn.adapter Faraday.default_adapter
            end
          end
        end
      end
    end
  end
end
