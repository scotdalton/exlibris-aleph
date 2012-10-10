source "http://rubygems.org"

# Declare your gem's dependencies in exlibris-aleph.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

group :development, :test do
  # jquery-rails is used by the dummy application
  gem "jquery-rails"

  platforms :jruby do
    gem 'jruby-openssl'
    gem 'activerecord-jdbcsqlite3-adapter', :require => 'jdbc-sqlite3', :require =>'arjdbc'
  end

  platforms :ruby do
    gem 'sqlite3'
  end
end
