# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name         = "caissa_guardian"
  spec.version      = File.read("VERSION.semver").chomp
  spec.author       = "Cyril Kato"
  spec.email        = "contact@cyril.email"
  spec.summary      = "Two-player legal move generator."
  spec.description  = spec.summary
  spec.homepage     = "https://developer.sashite.com/specs/"
  spec.license      = "MIT"
  spec.files        = Dir["LICENSE.md", "README.md", "lib/**/*"]

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/sashite/caissa_guardian.rb/issues",
    "documentation_uri" => "https://rubydoc.info/gems/caissa_guardian/index",
    "source_code_uri" => "https://github.com/sashite/caissa_guardian.rb"
  }

  spec.required_ruby_version = ">= 2.7.0"

  spec.add_dependency "feen", "~> 4.0.1"
  spec.add_dependency "qi", "~> 9.0.0.beta1"
  spec.add_dependency "ugoki", "~> 3.2.0.beta2"

  spec.add_development_dependency "brutal"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rubocop-performance"
  spec.add_development_dependency "rubocop-thread_safety"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "yard"
end
