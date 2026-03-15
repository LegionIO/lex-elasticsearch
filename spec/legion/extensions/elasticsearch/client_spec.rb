# frozen_string_literal: true

RSpec.describe Legion::Extensions::Elasticsearch::Client do # rubocop:disable Metrics/BlockLength
  let(:mock_conn) { instance_double(Faraday::Connection) }

  before do
    allow(Faraday).to receive(:new).and_return(mock_conn)
  end

  describe '#initialize' do
    it 'stores default options' do
      client = described_class.new
      expect(client.opts).to include(url: 'http://127.0.0.1:9200')
    end

    it 'accepts custom url' do
      client = described_class.new(url: 'http://es.local:9200')
      expect(client.opts[:url]).to eq('http://es.local:9200')
    end
  end

  describe 'index operations' do
    let(:client) { described_class.new }

    it 'lists indices' do
      allow(mock_conn).to receive(:get).with('_cat/indices?format=json').and_return(
        double(body: [{ 'index' => 'test' }])
      )
      result = client.list_indices
      expect(result[:indices]).to be_an(Array)
    end

    it 'creates an index' do
      allow(mock_conn).to receive(:put).and_return(double(body: { 'acknowledged' => true }))
      result = client.create_index(index: 'test')
      expect(result[:acknowledged]).to be true
    end

    it 'deletes an index' do
      allow(mock_conn).to receive(:delete).and_return(double(body: { 'acknowledged' => true }))
      result = client.delete_index(index: 'test')
      expect(result[:acknowledged]).to be true
    end

    it 'checks index existence' do
      allow(mock_conn).to receive(:head).and_return(double(status: 200))
      result = client.check_index(index: 'test')
      expect(result[:exists]).to be true
    end
  end

  describe 'document operations' do
    let(:client) { described_class.new }

    it 'indexes a document with id' do
      allow(mock_conn).to receive(:put).and_return(double(body: { 'result' => 'created', '_id' => '1' }))
      result = client.index_document(index: 'test', body: { title: 'doc' }, id: '1')
      expect(result[:result]).to eq('created')
    end

    it 'indexes a document without id' do
      allow(mock_conn).to receive(:post).and_return(double(body: { 'result' => 'created', '_id' => 'auto-id' }))
      result = client.index_document(index: 'test', body: { title: 'doc' })
      expect(result[:id]).to eq('auto-id')
    end

    it 'gets a document' do
      allow(mock_conn).to receive(:get).and_return(
        double(body: { 'found' => true, '_source' => { 'title' => 'doc' } })
      )
      result = client.get_document(index: 'test', id: '1')
      expect(result[:found]).to be true
    end

    it 'deletes a document' do
      allow(mock_conn).to receive(:delete).and_return(double(body: { 'result' => 'deleted' }))
      result = client.delete_document(index: 'test', id: '1')
      expect(result[:result]).to eq('deleted')
    end

    it 'updates a document' do
      allow(mock_conn).to receive(:post).and_return(double(body: { 'result' => 'updated' }))
      result = client.update_document(index: 'test', id: '1', body: { title: 'updated' })
      expect(result[:result]).to eq('updated')
    end
  end

  describe 'search operations' do
    let(:client) { described_class.new }

    it 'searches an index' do
      hits_data = [{ '_id' => '1', '_source' => { 'title' => 'doc' }, '_score' => 1.0 }]
      allow(mock_conn).to receive(:post).and_return(
        double(body: { 'hits' => { 'total' => { 'value' => 1 }, 'hits' => hits_data } })
      )
      result = client.search(index: 'test', query: { match_all: {} })
      expect(result[:total]).to eq(1)
      expect(result[:hits].size).to eq(1)
    end

    it 'counts documents' do
      allow(mock_conn).to receive(:post).and_return(double(body: { 'count' => 42 }))
      result = client.count(index: 'test')
      expect(result[:count]).to eq(42)
    end
  end
end
