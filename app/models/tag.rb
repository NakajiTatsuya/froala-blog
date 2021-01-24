class Tag < ApplicationRecord
	has_and_belongs_to_many :articles

    # articleが多い順に全てのtagを取得している
		# tag.allと記事数をselectし、記事数で降順に並び替え
	  def self.popular_sort_tags
		  Tag.select('tags.*', 'count(articles.id) AS num_of_articles').left_joins(:articles).group('tags.id').order('num_of_articles desc')
	  end

	  def self.popular_sort_tags_of_language
	    Tag.select('tags.*', 'count(articles.id) AS num_of_articles').left_joins(:articles).group('tags.id').where(is_language: true).order('num_of_articles desc')
    end
end
