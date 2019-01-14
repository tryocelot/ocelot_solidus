# desc "Explaining what the task does"
# task :ocelot_solidus do
#   # Task goes here
# end

namespace :config do
  desc "Copy configuration files from templates"
  task :copy do
    for file in Dir.glob("config/*.tpl") do
      system "cp -vi #{file} config/#{File.basename(file,".tpl")}"
    end
  end
end

namespace :ocelot do
  desc "Push orders up to Ocelot"
  task push: :environment do
    push_orders
  end

  private

  # This needs to become batch based.
  def push_orders
    Spree::Order.find_each do |order|
      OcelotSolidus::OrderJob.perform(order)
      print '.'
    end
  end
end
