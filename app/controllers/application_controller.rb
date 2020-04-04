class ApplicationController < ActionController::Base
  helper I18nHelper

  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :detect_variant

  helper_method :active_tab
  helper_method :authenticated?
  helper_method :current_locale
  helper_method :not_found

  class_attribute :active_tab

  def self.active_tab( tab=nil )
    self.active_tab = tab
  end

protected

  def authenticated?
    session[:auth_session] == 'admin'
  end

  def current_locale
    params[:locale] || I18n.default_locale
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

private

  def set_locale
    begin
      I18n.locale = current_locale.to_s
      cookies[:locale] = current_locale unless (cookies[:locale] && cookies[:locale] == current_locale)
    rescue Exception => e
      return not_found
    end
  end

  def detect_variant
    request.variant = case request.user_agent
      when (/iPhone/i)
      when (/Android.*mobile|mobile.*Android/i)
      when (/Windows Phone/i)
        :phone
      end
  end

  def default_url_options
    if I18n.default_locale != I18n.locale
      { :locale => I18n.locale  }
    else
      super
    end
  end

end
