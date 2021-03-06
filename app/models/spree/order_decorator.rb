Spree::Order.class_eval do
  if OcelotSolidus.enabled
    after_create_commit do
      OcelotSolidus::Orders::CreateJob.perform_now self
    end

    after_update_commit do
      OcelotSolidus::Orders::CreateJob.perform_now self
    end

    after_destroy_commit do
      OcelotSolidus::Orders::DeleteJob.perform_now self
    end
  end
end
