require 'workspace'

module Jobs
  class Tester
    @queue = :normal

    def self.perform(job_id)
      job = Job.find_by_id!(job_id)
      workspace = Workspace.new(job.build.ref)
      workspace.logger = Logger.new(STDOUT)
      # workspace.bundle_exec("rake -vt test:prepare")

      begin
        output = workspace.bundle_exec(job.command)
        job.status = 'success'
      rescue Workspace::CommandFailed => e
        raise e unless e.exitstatus == 2
        job.status = 'failure'
      end
      job.save!
    end

    def self.on_failure_save(exception, job_id)
      Job.save_error(job_id, filter_failure(exception))
    end
  end
end
