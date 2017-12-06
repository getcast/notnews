class NewsRepository < Repository
	attr_reader :news

	def initialize
		@news = Database[:news]
	end

	def batch_update(new_articles) 
		new_articles.each do |article|
			@news.insert(article)
		end
		puts "inserted!"
	end
end

