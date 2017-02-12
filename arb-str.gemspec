# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'arb/str/version'

Gem::Specification.new do |spec|
  spec.name          = "arb-str"
  spec.version       = Arb::Str::VERSION
  spec.authors       = ["AryBin"]
  spec.email         = ["arybin@163.com"]

  spec.summary       = %q{Enhance of String.}
  spec.description   = %q{Enhance of String.}
  spec.homepage      = "https://github.com/arybin-cn/arb-str"


  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
end
