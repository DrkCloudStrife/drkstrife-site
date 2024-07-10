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

  if article_data['imageLink'].present?
    attachment = Pathname.new('app/assets/images')
    attachment = attachment.join(article_data['imageLink'])
  end

  article = Article.find_or_initialize_by(payload)

  if attachment && !article.banner_image.present?
    article.banner_image.attach(
      io: attachment.open,
      filename: attachment.basename.to_s,
      content_type: 'image/jpeg'
    )
  end
  article.save!
end
