require 'workspace'

module Jobs
  class Builder
    @queue = :normal

    def self.perform(build_id)
      build = Build.find_by_id!(build_id)
      workspace = Workspace.new(build.ref)
        workspace.logger = Logger.new(STDOUT)

      commands =
        workspace.specs.map { |s| "rspec --failure-exit-code 2 #{s}" } +
        workspace.features.map { |f| "cucumber #{f}" }

      commands.each do |command|
        build.jobs.create!(command: command)
      end
    end

    def self.on_failure_save(exception, build_id)
      Build.save_error(build_id, exception)
    end
  end
end
