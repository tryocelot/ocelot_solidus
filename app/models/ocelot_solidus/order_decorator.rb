module OcelotSolidus
  module OrderDecorator
    extend ActiveSupport::Concern

    included do
      after_commit do
        OcelotSolidus::OrderJob.perform_later(self)
      end
    end
  end
end

Spree::Order.include Spree::OrderDecorator
