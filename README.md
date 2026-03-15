# lex-elasticsearch

Elasticsearch integration for [LegionIO](https://github.com/LegionIO/LegionIO). Manage indices and documents, and run search queries against Elasticsearch clusters from within task chains or as a standalone client library.

## Installation

```bash
gem install lex-elasticsearch
```

Or add to your Gemfile:

```ruby
gem 'lex-elasticsearch'
```

## Standalone Usage

```ruby
require 'legion/extensions/elasticsearch'

client = Legion::Extensions::Elasticsearch::Client.new(
  host: 'https://my-cluster.es.io:9200',
  api_key: 'my-api-key'
)

# Indices
client.list_indices
client.create_index(index: 'my-index')
client.check_index(index: 'my-index')
client.get_index(index: 'my-index')
client.delete_index(index: 'my-index')

# Documents
client.index_document(index: 'my-index', id: '1', body: { title: 'Hello' })
client.get_document(index: 'my-index', id: '1')
client.update_document(index: 'my-index', id: '1', body: { title: 'Updated' })
client.delete_document(index: 'my-index', id: '1')

# Search
client.search(index: 'my-index', query: { match: { title: 'Hello' } })
client.count(index: 'my-index')
```

## Runners

### Indices

| Method | Parameters | Description |
|--------|-----------|-------------|
| `list_indices` | (none) | List all indices |
| `create_index` | `index:` | Create an index |
| `delete_index` | `index:` | Delete an index |
| `check_index` | `index:` | Check if an index exists |
| `get_index` | `index:` | Get index settings and mappings |

### Documents

| Method | Parameters | Description |
|--------|-----------|-------------|
| `index_document` | `index:`, `id:`, `body:` | Index (create or replace) a document |
| `get_document` | `index:`, `id:` | Retrieve a document by ID |
| `update_document` | `index:`, `id:`, `body:` | Partially update a document |
| `delete_document` | `index:`, `id:` | Delete a document |

### Search

| Method | Parameters | Description |
|--------|-----------|-------------|
| `search` | `index:`, `query:` | Execute a search query |
| `count` | `index:` | Count documents in an index |

## Requirements

- Ruby >= 3.4
- Elasticsearch cluster
- `faraday` >= 2.0 (HTTP transport; uses ApiKey auth header)

## License

MIT
