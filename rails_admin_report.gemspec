$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_admin_report/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_admin_report"
  s.version     = RailsAdminReport::VERSION
  s.authors     = ["Rodrigo Hulle"]
  s.email       = ["rmhulle@gmail.com"]
  s.homepage    = "http://www.saude.es.gov.br"
  s.summary     = ["Summary of RailsAdminReport."]
  s.description = ["Description of RailsAdminReport."]
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.6"
end
