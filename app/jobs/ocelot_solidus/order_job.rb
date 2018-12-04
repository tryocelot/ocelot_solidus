module OcelotSolidus
  class OrderJob < BaseJob
    GRAPHQL_TYPES = {
      number: 'String!',
      storeId: 'String!',
      state: 'String!',
      currency: 'String!'
    }.freeze

    attr_reader :order, :variables

    def perform(order)
      @order = order
      @variables = build_variables

      push_mutation
    end

    private

    def build_variables
      hash = order.as_json.transform_keys do |key|
        key.to_s.camelize(:lower)
      end.select do |key, value|
        GRAPHQL_TYPES.keys.map(&:to_s).include?(key)
      end

      hash['storeId'] = order.id.to_s
      hash
    end

    def query
      <<~GRAPHQL.squish
      mutation CreateOrder(#{types}) {
        createOrder(#{input}) {
          id
        }
      }
      GRAPHQL
    end

    def types
      GRAPHQL_TYPES.map { |k, v| "$#{k}: #{v}" }.join(', ')
    end

    def input
      variables.keys.map { |k| "#{k}: $#{k}" }.join(', ')
    end

    def push_mutation
      uri = URI.parse(OcelotSolidus.api_url)
      headers = {
        'Content-Type': 'application/json',
        'Authorization': "Bearer #{OcelotSolidus.api_key}"
      }

      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.request_uri, headers)
      request.body = { query: query, variables: variables }.to_json

      http.request(request)
    end
  end
end
