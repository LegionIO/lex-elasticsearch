require 'legion/extensions/elasticsearch/version'

module Legion
  module Extensions
    module Elasticsearch
      extend Legion::Extensions::Core if Legion::Extensions.const_defined? :Core
    end
  end
end
