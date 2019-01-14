module OcelotSolidus
  module Orders
    class UpdateJob < < OcelotSolidus::Orders::BaseJob
      def perform(_order)
        true
      end
    end
  end
end
