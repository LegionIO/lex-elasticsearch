# lex-elasticsearch: Elasticsearch Integration for LegionIO

**Repository Level 3 Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-other/CLAUDE.md`
- **Grandparent**: `/Users/miverso2/rubymine/legion/CLAUDE.md`

## Purpose

Legion Extension that connects LegionIO to Elasticsearch clusters. Provides index and document management, search, and a standalone Client class for use outside the full framework.

**GitHub**: https://github.com/LegionIO/lex-elasticsearch
**License**: MIT
**Version**: 0.2.0

## Architecture

```
Legion::Extensions::Elasticsearch
├── Helpers::Client       # Faraday connection to ES with ApiKey auth
├── Runners::Indices      # list_indices, create_index, delete_index, check_index, get_index
├── Runners::Documents    # index_document, get_document, delete_document, update_document
├── Runners::Search       # search, count
└── Client                # Standalone class — includes all runners; config via kwargs
```

## Key Files

| Path | Purpose |
|------|---------|
| `lib/legion/extensions/elasticsearch.rb` | Entry point, extension registration |
| `lib/legion/extensions/elasticsearch/version.rb` | Version constant (0.2.0) |
| `lib/legion/extensions/elasticsearch/helpers/client.rb` | Builds Faraday connection with ApiKey auth |
| `lib/legion/extensions/elasticsearch/runners/indices.rb` | Index-level operations |
| `lib/legion/extensions/elasticsearch/runners/documents.rb` | Document CRUD operations |
| `lib/legion/extensions/elasticsearch/runners/search.rb` | Search and count operations |
| `lib/legion/extensions/elasticsearch/client.rb` | Standalone Client class |

## Dependencies

| Gem | Version | Purpose |
|-----|---------|---------|
| `faraday` | >= 2.0 | HTTP client for Elasticsearch REST API |

Replaces the previous `elasticsearch` gem dependency. Dev dependencies: `bundler`, `rake`, `rspec`, `rubocop`.

## Testing

14 examples across `spec/legion/extensions/elasticsearch_spec.rb` and `spec/legion/extensions/elasticsearch/client_spec.rb`.

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

---

**Maintained By**: Matthew Iverson (@Esity)
