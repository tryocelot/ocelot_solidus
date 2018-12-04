module OcelotSolidus
  class Engine < Rails::Engine
    isolate_namespace OcelotSolidus
    engine_name 'ocelot_solidus'

    config.to_prepare do
      Dir.glob(File.join(File.dirname(__FILE__), '../../../app/models/**/*_decorator.rb')) do |f|
        Rails.configuration.cache_classes ? require(f) : load(f)
      end
    end
  end
end
