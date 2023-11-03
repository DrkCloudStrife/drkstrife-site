class AddArticlesTable < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :title, comment: "The article's title"
      t.string :slug, unique: true, comment: 'Unique slug for URL access'
      t.text :body, comment: 'Article content'
      t.text :link_fa_icon, comment: 'Link Font Awesome icon'
      t.text :link_text, comment: 'Link text'
      t.boolean :published, comment: 'Flag to determine whether the article is visible in the home page'

      t.timestamps
    end
  end
end
