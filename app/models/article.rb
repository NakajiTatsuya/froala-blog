class Article < ApplicationRecord
	has_one_attached :image
	has_and_belongs_to_many :tags

	def self.search(search) #self.でクラスメソッドとしている
	    if search # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
	    	Article.where(['title ILIKE ?', "%#{search}%"])
	    else
	        Article.all #全て表示。
	    end
    end
	
end
