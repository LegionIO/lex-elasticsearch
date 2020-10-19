require_relative 'lib/legion/extensions/elasticsearch/version'

Gem::Specification.new do |spec|
  spec.name          = 'lex-elasticsearch'
  spec.version       = Legion::Extensions::Elasticsearch::VERSION
  spec.authors       = ['Esity']
  spec.email         = ['matthewdiverson@gmail.com']

  spec.summary       = 'LEX::Elasticsearch'
  spec.description   = 'Connections Legion to Elasticsearch'
  spec.homepage      = 'https://bitbucket.org/legion-io/lex-elasticsearch'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://bitbucket.org/legion-io/lex-elasticsearch'
  spec.metadata['changelog_uri'] = 'https://bitbucket.org/legion-io/lex-elasticsearch'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'legionio'
  spec.add_dependency 'elasticsearch'
end
