require 'simplecov'
SimpleCov.start

require 'bundler/setup'
require 'pry'
require 'jekyll_i18n_multi_page'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  def root_dir(*dirs)
    File.expand_path(File.join('..', *dirs), __dir__)
  end

  def test_dir(*dirs)
    root_dir('spec', *dirs)
  end

  def dist(*dirs)
    root_dir('spec', 'dist', *dirs)
  end
end
