module OcelotSolidus
  class BaseJob < ActiveJob::Base
    queue_as OcelotSolidus.queue
  end
end
