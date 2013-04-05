require 'spec_helper'
require 'jobs/builder'

describe Jobs::Builder do

  describe '#perform' do
    it 'should create jobs for each spec and feature' do
      build = Factory.build
      Jobs::Builder.perform(build.id)
      build.reload
      expect(build.jobs.count).to_not be_zero
    end
  end

  describe '#on_failure_save' do
    it 'should save the exception to the build' do
      build = Factory.build
      error = StandardError.new
      Build.should_receive(:save_error).with(build.id, error)
      Jobs::Builder.on_failure_save(error, build.id)
    end
  end
end
