module OcelotSolidus
  module Orders
    class PushJob < BaseJob
      GREEN = "\033[1;32m".freeze
      ENDC = "\033[0;0m".freeze

      def perform
        start_time = Time.current
        Spree::Order.find_each.map do |order|
          new_thread(order)
        end.each(&:join)

        duration = Time.current - start_time
        puts "\n\nCompleted in #{duration.round(2)} seconds"
      end

      private

      def new_thread(order)
        Thread.new do
          OcelotSolidus::Orders::CreateJob.perform_now(order)
          print "#{GREEN}.#{ENDC}"
        end
      end
    end
  end
end
