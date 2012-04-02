require 'my_plugin'
require 'rails'
module Exlibris
  module Aleph
    class Railtie < Rails::Railtie
      railtie_name :exlibris:aleph

      rake_tasks do
        load "tasks/exlibris-aleph_tasks.rake"
      end
    end
  end
end