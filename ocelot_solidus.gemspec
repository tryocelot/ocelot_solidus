$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'ocelot_solidus/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'ocelot_solidus'
  s.version     = OcelotSolidus::VERSION
  s.authors     = ['Ben A. Morgan']
  s.email       = ['ben@benmorgan.io']
  s.homepage    = 'https://github.com/tryocelot/solidus'
  s.summary     = 'Ocelot Analytics for Solidus.'
  s.description = 'Ocelot Analytics for Solidus.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'solidus_core', '~> 2.0'
  s.add_dependency 'thor'

  s.add_development_dependency 'sqlite3'

  s.executables = %w[ocelot]
end
