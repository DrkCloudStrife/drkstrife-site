module ApplicationHelper

  def canonical_link
    link = 'http://'
    link += request.host.downcase
    link += if current_locale != I18n.default_locale
      request.path.downcase[current_locale.length...request.path.length]
    else
      request.path.downcase
    end

    link
  end

end
