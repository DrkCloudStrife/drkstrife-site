module Admin
  class HomeController < ApplicationController
    active_tab :admin

    before_action :require_authentication

    def index
      self.class.active_tab = :admin
      @articles = Articles.list_articles
    end

    def logout
      reset_session
      session[:auth_session] = 'logged_out' # to invalidate basic auth
      redirect_to root_path and return
    end

    private

    def require_authentication
      return not_found if Rails.env.production?
      return if authenticated?

      if authenticate_with_http_basic { |un, pw| ENV['AUTHENTICATION_NAME'] == un && ENV['AUTHENTICATION_PASSWORD'] == pw && session[:auth_session].nil? }
        session[:auth_session] = 'admin'
      else
        reset_session
        request_http_basic_authentication
      end
    end

  end
end
