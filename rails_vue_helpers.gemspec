
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rails_vue_helpers/version"

Gem::Specification.new do |spec|
  spec.name          = "rails_vue_helpers"
  spec.version       = RailsVueHelpers::VERSION
  spec.authors       = ["Kristaps Kulikovskis"]
  spec.email         = ["kristaps.kulikovskis@gmail.lv"]

  spec.summary       = %q{ActionView helper methods for injecting Vue.js components into your Rails views}
  spec.description   = %q{ActionView helper methods for injecting Vue.js components into your Rails views}
  spec.homepage      = "https://github.com/LeKristapino/rails_vue_helpers"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  # spec.bindir        = "exe"
  # spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport', ['>= 4.1', '< 6.0']
  spec.add_dependency 'actionview', ['>= 4.1', '< 6.0']

  spec.add_development_dependency "bundler", "~> 1.16.a"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.6"
end
