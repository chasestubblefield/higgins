require 'spec_helper'

describe AuthController do
  describe 'GET login' do
    it 'redirects to GitHub for "user scope" authorization' do
      Higgins::Application.config.stub(:github).and_return('client_id' => 'FOO')
      expected_redirect = 'https://github.com/login/oauth/authorize?client_id=FOO&scope=user'
      get :login
      expect(response).to redirect_to expected_redirect
    end
  end
end
