class Tag < ApplicationRecord
	has_and_belongs_to_many :articles

    # articleが多い順に全てのtagを取得している
	def self.popular_sort_tags
	    Tag.select('tags.*', 'count(articles.id) AS acs').left_joins(:articles).group('tags.id').order('acs desc')
    end
end
