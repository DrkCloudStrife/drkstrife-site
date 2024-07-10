# http://api.rubyonrails.org/classes/ActionView/Helpers/TranslationHelper.html#method-i-translate

module I18nHelper
  def translate(key, options={})
    translation = super(key, **options.merge(raise: true))

    unless !!options.fetch(:capitalize, true)
      return translation.downcase
    end

    return translation
  rescue I18n::MissingTranslationData
    translation = key.split('.').last.titleize

    unless !!options.fetch(:capitalize, true)
      return translation.downcase
    end

    return translation
  end

  alias :t :translate
end
