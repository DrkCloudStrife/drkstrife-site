# Run this in a rails console

StaticArticles.list_articles.reverse.each do |article_data|
  payload = {
    title: article_data["title"],
    body: article_data["markdown"],
    link_fa_icon: article_data["linkIcon"],
    link_text: article_data["linkText"],
    published: true,
    created_at: Date.parse(article_data["createdAt"])
  }

  article = Articles.new(payload)
  article.save!
end
