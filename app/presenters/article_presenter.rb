class ArticlePresenter < SimpleDelegator

  def to_json(opts = {})
    opts.merge!(methods: :banner_url)
    # raise opts.inspect

    super(opts)
  end
end
