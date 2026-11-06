# frozen_string_literal: true

require_relative "lib/huntapi/version"

Gem::Specification.new do |spec|
  spec.name = "huntapi"
  spec.version = HuntApi::VERSION
  spec.authors = ["HuntAPI"]
  spec.email = ["contact@huntapi.com"]

  spec.summary = "Official Ruby SDK for the HuntAPI media download API."
  spec.description = "Download video and audio from public media URLs, or extract their metadata, with one async REST API."
  spec.homepage = "https://www.huntapi.com"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/huntapi/huntapi-ruby/issues",
    "documentation_uri" => "https://docs.huntapi.com",
    "homepage_uri" => spec.homepage,
    "rubygems_mfa_required" => "true",
    "source_code_uri" => "https://github.com/huntapi/huntapi-ruby"
  }

  spec.files = Dir["LICENSE", "README.md", "examples/**/*", "lib/**/*.rb", "sig/**/*.rbs"]
  spec.require_paths = ["lib"]
end
