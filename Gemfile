source 'http://rubygems.org'

# Declare your gem's dependencies in exlibris-aleph.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec
gem 'coveralls', '~> 0.7.0', require: false, :group => :test
gem 'pry'

platforms :rbx do
  gem 'rubysl', '~> 2.0' # if using anything in the ruby standard library
  gem 'rubinius-coverage'
  gem 'rubysl-test-unit'
  gem 'racc'
end
