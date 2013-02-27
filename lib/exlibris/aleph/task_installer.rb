module Exlibris
  module Aleph
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