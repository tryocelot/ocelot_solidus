module OcelotSolidus
  class BaseJob < ActiveJob::Base
    queue_as :ocelot
  end
end
