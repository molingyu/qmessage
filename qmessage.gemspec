# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'qmessage/version'

Gem::Specification.new do |spec|
  spec.name          = "qmessage"
  spec.version       = Qmessage::VERSION
  spec.authors       = ["molingyu"]
  spec.email         = ["z1422716486@hotmail.com"]

  spec.summary       = %q{QQ message processor}
  spec.description   = %q{QQ message processor}
  spec.homepage      = "https://github.com/molingyu/qmessage"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.executables   = 'qmsg'
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "json", "~> 2.0.2"
end
