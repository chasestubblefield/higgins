class WorkersController < ApplicationController
  require_authentication!
  enable_polling!

  def index
    @workers = Resque.workers
  end
end
