class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :check_authentication
  def check_authentication
    @authenticated = session[:authenticated].present?
  end

  class << self
    def enable_polling!
      layout :optional_layout
      @polling = true
    end

    def polling?
      !!@polling
    end

    def require_authentication!
      if Higgins::Application.config.github
        before_filter :redirect_unless_authentication
      end
    end
  end

  def optional_layout
    params['body'] == '1' ? false : 'application'
  end

  def redirect_unless_authentication
    redirect_to root_path unless @authenticated
  end
end
