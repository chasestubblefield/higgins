require 'spec_helper'

describe Build do
  describe '#save_error' do
    it 'should set error on the given build' do
      build = Factory.build
      my_error = StandardError.new
      Build.save_error(build.id, my_error)
      build.reload
      expect(build).to be_persisted
      expect(build.status).to eq 'error'
      expect(build.error).to eq my_error
    end
  end
end
