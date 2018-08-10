$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'solidushub_analytics/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'solidushub_analytics'
  s.version     = SolidushubAnalytics::VERSION
  s.authors     = ['Ben A. Morgan']
  s.email       = ['ben@benmorgan.io']
  s.homepage    = 'TODO'
  s.summary     = 'TODO: Summary of SolidushubAnalytics.'
  s.description = 'TODO: Description of SolidushubAnalytics.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.1.6'

  s.add_development_dependency 'sqlite3'
end
