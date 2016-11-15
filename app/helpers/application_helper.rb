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

  def page_specific_scripts
    path = "#{controller_name}/#{ action_name}.js"
    if has_asset?(path)
      return javascript_include_tag path
    end
  end

  def has_asset?(path)
    !Rails.application.assets.find_asset(path).nil?
  end

end
