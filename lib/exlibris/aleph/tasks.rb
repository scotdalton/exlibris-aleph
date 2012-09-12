module Exlibris
  module Aleph
    class Tasks
      class << self
        def rake_tasks(&blk)
          @rake_tasks ||= []
          @rake_tasks << blk if blk
          @rake_tasks
        end
      end
      rake_tasks do
        load "tasks/exlibris-aleph_tasks.rake"
      end
      require 'rake'
      extend Rake::DSL
      self.rake_tasks.each { |block| self.instance_exec(app, &block) }
      # Also load tasks from all superclasses
      klass = self.superclass
      while klass.respond_to?(:rake_tasks)
        klass.rake_tasks.each { |t| self.instance_exec(app, &t) }
        klass = klass.superclass
      end
    end
  end
end