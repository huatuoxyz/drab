# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "drab/version"

Gem::Specification.new do |s|
  s.name        = "drab"
  s.version     = Drab::VERSION
  s.authors     = ["Dongri Jin"]
  s.email       = ["dongriab@gmail.com"]
  s.homepage    = "https://github.com/dongriab/Drab.gem"
  s.summary     = %q{Terminal Twitter Facebook Client}
  s.description = %q{Twitter Client on Terminal with Twitter Streaming API. Facebook Post}

  s.rubyforge_project = "drab"

  s.files         = `git ls-files`.split("\n") + ['consumer.yml']
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "twitter-stream"
  s.add_runtime_dependency "notify"
  s.add_runtime_dependency "i18n"
  s.add_runtime_dependency "activesupport"
  s.add_runtime_dependency "awesome_print"
  s.add_runtime_dependency "launchy"
  s.add_runtime_dependency "oauth"
  s.add_runtime_dependency "twitter_oauth", "= 0.4.3"
  s.add_runtime_dependency "facebook_oauth"
  s.add_runtime_dependency "slop", "~> 2.0"
  s.add_development_dependency "rspec", "~> 2.0"
  s.add_development_dependency "bundler"

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
