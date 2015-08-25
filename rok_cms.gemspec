$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rok_cms/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rok_cms"
  s.version     = RokCms::VERSION
  s.authors     = ["Sean Earle"]
  s.email       = ["sean.r.earle@gmail.com"]
  s.homepage    = "http://www.oequacki.com/"
  s.summary     = "A CMS engine."
  s.description = "This is a rails 4 CMS engine."
  s.license     = "Beerware"

  s.files = Dir["{app,config,db,lib}/**/*", "Rakefile", "README.rdoc"]
  s.require_path ='lib'
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.3"

  #s.add_dependency "rok_base"
end
