module OcelotSolidus
  module Orders
    class BaseJob < OcelotSolidus::BaseJob
      GRAPHQL_TYPES = {
        number: 'String!',
        storeId: 'String!',
        state: 'String!',
        currency: 'String!'
      }.freeze

      HEADERS = {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{OcelotSolidus.api_key}"
      }.freeze

      OCELOT_URI = URI.parse(OcelotSolidus.api_url).freeze

      attr_reader :order, :variables

      def types
        GRAPHQL_TYPES.map { |k, v| "$#{k}: #{v}" }.join(', ')
      end

      def build_variables
        hash = order.as_json.transform_keys do |key|
          key.to_s.camelize(:lower)
        end.select do |key, value|
          GRAPHQL_TYPES.keys.map(&:to_s).include?(key)
        end

        hash['storeId'] = order.id.to_s

        Rails.logger.info "Ocelot Spree::Order Variables: #{hash.inspect}"
        hash
      end

      def input
        variables.keys.map { |k| "#{k}: $#{k}" }.join(', ')
      end

      def push_mutation
        body = { query: query, variables: variables }.to_json
        response = Net::HTTP.post OCELOT_URI, body, HEADERS
        Rails.logger.info response.body
        response
      end
    end
  end
end
