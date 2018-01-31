# frozen_string_literal: true

$LOAD_PATH.append File.expand_path("../lib", __FILE__)
require "scrivstats/identity"

Gem::Specification.new do |spec|
  spec.name = Scrivstats::Identity.name
  spec.version = Scrivstats::Identity.version
  spec.platform = Gem::Platform::RUBY
  spec.authors = ["Brant Herbert"]
  spec.email = ["bherbertaz@gmail.com"]
  spec.homepage = "https://github.com/bherbert/scrivstats"
  spec.summary = "Perform an analysis of Scrivener project"
  spec.license = "MIT"

  spec.required_ruby_version = "~> 2.5"
  spec.add_dependency "nokogiri", "~> 1.8"
  spec.add_dependency "runcom", "~> 2.0"
  spec.add_dependency "thor", "~> 0.20"
  spec.add_development_dependency "bundler-audit", "~> 0.6"
  spec.add_development_dependency "gemsmith", "~> 11.1"
  spec.add_development_dependency "git-cop", "~> 2.0"
  spec.add_development_dependency "guard-rspec", "~> 4.7"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "pry-byebug", "~> 3.5"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "reek", "~> 4.7"
  spec.add_development_dependency "rspec", "~> 3.7"
  spec.add_development_dependency "rubocop", "~> 0.52"

  spec.files = Dir["lib/**/*"]
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.executables << "scrivstats"
  spec.require_paths = ["lib"]
end
