class ArticlePresenter < Presenter

  module Decorators
    def banner_url
      return unless self.banner_image.present?

      Rails.application.routes.url_helpers.rails_blob_path(self.banner_image, only_path: true)
    end
  end

end
