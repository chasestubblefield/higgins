require 'filter_backtrace'
require 'jobs/tester'

class Job < ActiveRecord::Base
  serialize :error

  def self.save_error(id, err)
    FilterBacktrace.filter_out(err, '/lib/resque/job.rb')
    where(id: id).update_all(error: err, status: 'error')
  end

  # Associations
  belongs_to :build

  # Validations
  VALID_STATUSES = %w(none success failure error)
  validates :status, inclusion: { in: VALID_STATUSES, message: 'invalid status' }

  # Callbacks
  after_initialize :initialize_status
  def initialize_status
    self.status ||= 'none'
  end

  # after_commit :enqueue_tester, on: :create
  def enqueue_tester
    Resque.enqueue(Jobs::Tester, self.id)
  end

end
