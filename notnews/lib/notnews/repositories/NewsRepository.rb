class NewsRepository < Hanami::Repository
	self.relation = :news

	mapping do
		attribute :id, from: :id
		attribute :url, from: :url
		attribute :published, from: :published
		attribute :image, from: :image
		attribute :source, from: :source
		attribute :title, from: :title
	end
	
	def take(limit)
		news.order{published.desc}.limit(limit)
	end
end
