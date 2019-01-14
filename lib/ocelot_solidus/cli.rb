require_relative File.expand_path('config/environment', Dir.pwd)

module OcelotSolidus
  class Cli < Thor
    RELATIVE_CONFIG_PATH = 'config/initializers/ocelot_solidus.rb'.freeze

    desc "Installs files and pushes order data up to Ocelot.",
      "Installs files and pushes order data up to Ocelot."
    def install(api_key)
      copy_files(api_key) && push
    end

    desc "Copies installation files to your application.",
      "Copies installation files to your application."
    def copy_files(api_key)
      if File.exist?(config_path)
        print_warning
        return false
      end

      write_initializer(config_path, api_key)
      true
    end

    desc "Pushes all of the order data up to Ocelot in batches.",
      "Pushes all of the order data up to Ocelot in batches."
    def push
      OcelotSolidus::Orders::PushJob.perform_now
    end

    private

    def write_initializer(path, api_key)
      FileUtils.mkdir_p(File.dirname(path))

      File.open(path, 'w') do |f|
        f.puts <<~RUBY
          OcelotSolidus.setup do |config|
            # Reminder: Please take good care in where you store this key.
            #
            config.api_key = '#{api_key}'

            # Any functionality that occurs with Ocelot pushing data up to
            # ocelot.cat will check this config setting.
            #
            config.enabled = Rails.env.production?

            # Ocelot pushes data up with ActiveJob in the `ocelot` queue. If you
            # are using Sidekiq, please add the `ocelot` queue as a low priority
            # or configure it to a specific queue in your config. The default
            # queue is `:ocelot`.
            #
            # config.queue = :ocelot
          end
        RUBY
      end

      say <<~OUT, :green
        An initializer for Ocelot has been created at:

          #{RELATIVE_CONFIG_PATH}

        Please visit this config and update it to best suit your needs.
      OUT
    end

    def config_path
      File.expand_path(RELATIVE_CONFIG_PATH)
    end

    def print_warning
      @printed ||= say <<~OUT, :yellow
        A #{RELATIVE_CONFIG_PATH} already exists for your application.
        Visit your dashboard at https://ocelot.cat or remove the initializer
        to set it up as a new store on Ocelot.
      OUT
    end
  end
end
