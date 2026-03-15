# frozen_string_literal: true

require 'legion/extensions/elasticsearch/version'
require 'legion/extensions/elasticsearch/helpers/client'
require 'legion/extensions/elasticsearch/runners/indices'
require 'legion/extensions/elasticsearch/runners/documents'
require 'legion/extensions/elasticsearch/runners/search'
require 'legion/extensions/elasticsearch/client'

module Legion
  module Extensions
    module Elasticsearch
      extend Legion::Extensions::Core if Legion::Extensions.const_defined? :Core
    end
  end
end
