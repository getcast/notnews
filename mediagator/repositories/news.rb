class NewsRepository < Repository
	attr_reader :news
	attr_reader :feeds

	def initialize
		@news = Database[:news]
		@feeds = Database[:feeds]
	end

	def batch_update(new_articles) 
		new_articles.each do |article|
			@news.insert(article)
		end
		puts "inserted!"
	end

	def last_updated(url)
		entry = @feeds.where(url: url).first
		lu = nil
		if entry == nil
			@feeds.insert(url: url)
			puts "insert feed"
		else
			lu = entry[:last_updated]
			puts "got date"
		end

		lu
	end


	def update_date(url)
		@feeds.where(url: url).update(last_updated: Time.now)
	end
end

