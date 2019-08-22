# Normally this would hit an ActiveRecord model to fetch articles. However, I'm
# challenging myself by not using a database, this iteration will use JSON
# files as a base, I might consider changing it to YAML. I just want to provide
# alternatives to using a database model.
class Articles

  ARTICLE_DATA_PATH = "articles/data/"

  class << self
    def articles
      Dir.glob(path).inject([]) do |memo, article|
        file = Pathname.new(article)
        data = JSON.parse(file.read) unless file.empty?
        if data
          data['slug'] = file.basename.sub_ext('')
          memo << data
        end
        memo
      end
    end

    def list_articles
      articles.sort_by{|article| article['id']}.reverse!
    end

  private

    def path
      Rails.root.join('app/views').join(ARTICLE_DATA_PATH).join("*.json")
    end

  end
end

