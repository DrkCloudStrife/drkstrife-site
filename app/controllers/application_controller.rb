class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  helper_method :current_locale
  helper_method :not_found

protected

  def current_locale
    params[:locale] || I18n.default_locale
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

private

  def set_locale
    begin
      I18n.locale = current_locale
    rescue Exception => e
      raise ActionController::RoutingError.new('Not Found')
    end
  end

end
