module OcelotSolidus
  module Orders
    class CreateJob < OcelotSolidus::Orders::BaseJob
      def perform(order)
        @order = order
        @variables = build_variables

        push_mutation
      end

      private

      def query
        <<~GRAPHQL.squish
        mutation CreateOrder(#{types}) {
          createOrder(#{input}) { id }
        }
        GRAPHQL
      end
    end
  end
end
