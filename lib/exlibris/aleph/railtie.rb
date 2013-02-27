module Exlibris
  module Aleph
    class Railtie < Rails::Railtie
      rake_tasks do
        load "tasks/exlibris-aleph_tasks.rake"
      end
    end
  end
end