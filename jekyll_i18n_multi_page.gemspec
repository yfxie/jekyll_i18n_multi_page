
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "jekyll_i18n_multi_page/version"

Gem::Specification.new do |spec|
  spec.name          = "jekyll_i18n_multi_page"
  spec.version       = JekyllI18nMultiPage::VERSION
  spec.authors       = ["Yi Feng"]
  spec.email         = ["yfxie@me.com"]

  spec.summary       = %q{Jekyll plugin for handling I18n multiple pages.}
  spec.description   = %q{Generate multiple pages for different locales based on single template.}
  spec.homepage      = "https://github.com/yfxie/jekyll_i18n_multi_page"
  spec.license       = "MIT"


  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.12"
  spec.add_development_dependency "simplecov", "~> 0.17"
  spec.add_development_dependency "appraisal", "~> 2.2"

  spec.add_dependency "jekyll", ">= 3.0"
  spec.add_dependency "i18n"
  spec.add_dependency "activesupport", ">= 6", "< 8"
end
