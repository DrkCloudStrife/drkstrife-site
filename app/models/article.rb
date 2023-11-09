class Article < ApplicationRecord

  has_one_attached :banner_image

  slug :title_for_slug

  validates :title,
    presence: { message: "Title can't be blank" }

  validates :slug,
    presence: true,
    uniqueness: true

  scope :published, -> { where(published: true) }
  scope :list_articles, -> { published.order("id DESC") }

  def title_for_slug
    [created_at.year, created_at.month, created_at.day, title].join('-')
  end

end
