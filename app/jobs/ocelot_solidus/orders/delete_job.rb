module OcelotSolidus
  module Orders
    class DeleteJob < OcelotSolidus::Orders::BaseJob
      def perform(order)
        @order = order
        @variables = { storeId: order.id.to_json }

        push_mutation
      end

      private

      def query
        <<~GRAPHQL.squish
        mutation DeleteOrder($storeId: String!) {
          deleteOrder(#{input}) { count }
        }
        GRAPHQL
      end
    end
  end
end
