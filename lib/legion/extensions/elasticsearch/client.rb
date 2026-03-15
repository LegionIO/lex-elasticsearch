# frozen_string_literal: true

require_relative 'helpers/client'
require_relative 'runners/indices'
require_relative 'runners/documents'
require_relative 'runners/search'

module Legion
  module Extensions
    module Elasticsearch
      class Client
        include Helpers::Client
        include Runners::Indices
        include Runners::Documents
        include Runners::Search

        attr_reader :opts

        def initialize(url: 'http://127.0.0.1:9200', api_key: nil, **extra)
          @opts = { url: url, api_key: api_key, **extra }.compact
        end

        def connection(**override)
          super(**@opts, **override)
        end
      end
    end
  end
end
