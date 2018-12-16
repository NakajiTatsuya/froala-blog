class Article < ApplicationRecord
	has_one_attached :image
	has_and_belongs_to_many :tags
	
end
