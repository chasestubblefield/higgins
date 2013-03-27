class JobsController < ApplicationController
  def enqueue
    Resque.enqueue(Jobs::Tester, params[:id])
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end
end
