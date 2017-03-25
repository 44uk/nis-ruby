# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nis/version'

Gem::Specification.new do |spec|
  spec.name        = 'nis'
  spec.version     = Nis::VERSION
  spec.authors     = ['Yoshiyuki Ieyama']
  spec.email       = ['yukku0423@gmail.com']

  spec.summary     = %q{Ruby client library for the NEM Infrastructure Server API}
  spec.description = %q{Ruby client library for the NEM Infrastructure Server API}
  spec.homepage    = 'https://github.com/44uk/nis-ruby'
  spec.license     = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.metadata['yard.run'] = 'yri'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'yard', '~> 0.9'
  spec.add_development_dependency 'rubocop', '~> 0.47'
  spec.add_development_dependency 'timecop', '~> 0.8'
  spec.add_development_dependency 'webmock', '~> 2.3'
  spec.add_development_dependency 'pry', '~> 0.10'

  spec.add_dependency 'faraday', '~> 0.11'
  spec.add_dependency 'thor', '~> 0.19'
end
