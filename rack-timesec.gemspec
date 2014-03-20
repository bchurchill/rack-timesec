# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = 'rack-timesec'
  s.version = '1.0.0'
  s.license = 'MIT'

  s.authors = ["Berkeley Churchill"]
  s.description = "A rack middleware to prevent timing attacks"
  s.email = "berkeley@berkeleychurchill.com"

  s.files = Dir.glob("lib/**/*") + %w(README.md)
  s.require_paths = ["lib"]
  s.summary = "Prevent timing attacks"

  s.required_ruby_version = '>= 1.9.2'

  s.add_dependency 'rack'
end

