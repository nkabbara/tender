lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require "tender/version"
 
Gem::Specification.new do |s|
  s.name        = "tender"
  s.version     = Tender::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nash Kabbara"]
  s.email       = ["nash@zipzoomauto.com"]
  s.homepage    = "http://www.zipzoomauto.com"
  s.summary     = "Talk to tender."
  s.description = "A simple API wrapper to talk to tender. We use this all over ZipZoomAut's app"
 
  s.required_rubygems_version = ">= 1.3.6"
 
  s.add_dependency("httparty", "~> 0.4")
  s.add_dependency("hashie", "~> 0.1") 
  s.add_dependency("addressable", "~> 2.2") 
  s.add_dependency("activesupport", "~> 2.3")
  s.add_development_dependency("rspec", "~> 1.3")
 
  s.files        = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.md)
  s.require_path = 'lib'
end
