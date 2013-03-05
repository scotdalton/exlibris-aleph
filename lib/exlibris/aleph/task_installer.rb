module Exlibris
  module Aleph
    if defined?(::Rails) && ::Rails.version >= '3.1.0'
      class Railtie < Rails::Railtie
        rake_tasks do
          load "tasks/exlibris-aleph_tasks.rake"
        end
      end
    else
      require 'rake'
      class TaskInstaller
        include Rake::DSL if defined? Rake::DSL
        class << self
          def install_tasks
            @rake_tasks ||= []
            @rake_tasks << load("tasks/exlibris-aleph_tasks.rake")
            @rake_tasks
          end
        end
      end
    end
  end
end