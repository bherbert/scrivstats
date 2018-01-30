$LOAD_PATH.append File.expand_path("../lib", __FILE__)
require "scrivstats/identity"

Gem::Specification.new do |spec|
  spec.name = ScrivStats::Identity.name
  spec.version     = ScrivStats::Identity.version
  spec.summary     = 'Scrivener Stats'
  spec.platform = Gem::Platform::RUBY
  spec.description = 'Generate some stats on a Scrivener project'
  spec.authors     = ['Brant Herbert']
  spec.email       = 'bherbertaz@gmail.com'
  spec.homepage    = 'https://github.com/bherbert/scrivstats'
  spec.files       = ['lib/scrivstats.rb']
  spec.license = "MIT"

  spec.required_ruby_version = '~> 2.5'
  spec.add_dependency 'nokogiri', '~> 1.8'
  spec.add_dependency 'rtf', '~> 0.3'
  spec.add_dependency "runcom", "~> 2.0"
  spec.add_dependency "thor", "~> 0.20"

  spec.files = Dir['lib/**/*']
  spec.extra_rdoc_files = Dir['README*', 'LICENSE*']
  spec.executables << "scrivstats"
  spec.require_paths = ['lib']
end
