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

  def has_asset?(path)
    if Rails.configuration.assets.compile
      Rails.application.precompiled_assets.include?(path)
    else
      Rails.application.assets_manifest.assets[path].present?
    end
  end

end
