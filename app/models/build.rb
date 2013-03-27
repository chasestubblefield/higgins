require 'filter_backtrace'
require 'jobs/builder'

class Build < ActiveRecord::Base

  def self.save_error(id, err)
    FilterBacktrace.filter_out(err, '/lib/resque/job.rb')
    where(id: id).update_all(error: err, status: 'error')
  end

  # Attributes
  serialize :error

  has_many :jobs

  # Scopes

  def self.newest_first_paginated(page, per_page)
    order('created_at DESC').limit(per_page).offset(per_page*(page-1))
  end

  # Validations
  validates_presence_of :name, :ref
  VALID_STATUSES = %w(none success failure error)
  validates :status, inclusion: { in: VALID_STATUSES, message: 'invalid status' }

  # Callbacks
  after_initialize :initialize_status
  def initialize_status
    self.status ||= 'none'
  end

  # after_commit :enqueue_builder, on: :create
  def enqueue_builder
    Resque.enqueue(Jobs::Builder, self.id)
  end

end
