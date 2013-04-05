require 'faraday'

class AuthController < ApplicationController

  def login
    query_string = {
      client_id: Higgins::Application.config.github['client_id'],
      scope: 'user',
    }.to_query
    redirect_to "https://github.com/login/oauth/authorize?#{query_string}"
  end

  def logout
    session.delete(:authenticated)
    redirect_to root_path
  end

  def callback
    if user_in_organization?(access_token_from_code(params[:code]))
      session[:authenticated] = true
    end
    redirect_to root_path
  end

  private

  def access_token_from_code(code)
    response = Faraday.post('https://github.com/login/oauth/access_token', {
      client_id: Higgins::Application.config.github['client_id'],
      client_secret: Higgins::Application.config.github['client_secret'],
      code: code,
    }).body
    response = Rack::Utils.parse_query(response)
    response['access_token']
  end

  def user_in_organization?(access_token)
    org_login = Higgins::Application.config.github['restrict_to_org']
    response = Faraday.get('https://api.github.com/user/orgs', access_token: access_token).body
    response = JSON.parse(response)
    response.any? { |o| o['login'] == org_login }
  end
end
