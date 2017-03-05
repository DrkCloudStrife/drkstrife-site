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
    @partial ||= action_name
    path = "#{controller_name}/#{@partial}.js"

    if has_asset?(path)
      return javascript_include_tag path, data: { turbolinks_track: true }
    end
  end

  # NOTE: This is only the case because I'm using Heroku. If you're using
  # nginx or other web server for your production environment, I recommend
  # to check this anwswer: http://stackoverflow.com/a/35319530
  def has_asset?(path)
    !Rails.application.assets.find_asset(path).nil?
  end

end
