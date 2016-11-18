require 'cassandra'
require 'json'

require_relative 'query_builder'

class Runner
  def initialize(file_path, keyspace = nil)
    @file_path  = file_path
    @keyspace   = keyspace || 'sesac'
  end

  def from_json
    file = File.new(@file_path, 'r')

    while (line = file.gets)
      item = QueryBuilder.new(JSON.parse(line))

      run_cql item.query
    end

    file.close
  end

  private

  def run_cql(query)
    cassandra_session.execute query
  end

  def cassandra_session
    @cassandra_session ||= connect_to_cassandra
  end

  def connect_to_cassandra
    Cassandra.cluster.connect(@keyspace)
  end
end
