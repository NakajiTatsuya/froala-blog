class CreateArticlesTagsTable < ActiveRecord::Migration[5.2]
  def change
  	create_table :articles_tags, :id => false do |t|
      t.integer :article_id, null: false
      t.integer :tag_id, null: false
    end
  end
end
