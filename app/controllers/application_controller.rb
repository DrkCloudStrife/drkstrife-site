class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  def set_locale
    begin
      I18n.locale = params[:locale] || I18n.default_locale
    rescue Exception => e
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end
