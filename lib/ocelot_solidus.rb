require 'net/http'

require 'ocelot_solidus/engine'
require 'ocelot_solidus/version'

module OcelotSolidus
  mattr_accessor :api_url
  @@api_url = 'https://ocelot.cat/api'

  mattr_accessor :api_key
  @@api_key = ''

  mattr_accessor :enabled
  @@enabled = false

  mattr_accessor :queue
  @@queue = :ocelot

  def self.setup
    yield self
  end
end
