Database.config \
        adapter: :postgres, \
        user: 'notnews', \
        password: 'fake', \
        host: 'localhost', \
        database: 'notnews' \
do
	create_table?(:news) do  # example
		primary_key :id
		String :url, null: false
		DateTime :published, null: false, default: Sequel::CURRENT_TIMESTAMP
		String :image, null: true
		String :source, null: false
		String :title, null: true
	end
	create_table?(:feeds) do 
		primary_key :id
		String :url, null: false
		DateTime :last_updated
	end
end

Application.config do
	pool do # example 1
		sources  'http://www.clickhole.com/feeds/rss' # Sources list
		extractor HoleExtractor        # Extractor
		repository NewsRepository      # Repository
		wait_time 10
	end

	pool do # you can add more poolers
		sources "http://www.theonion.com/rss"
		extractor OnionExtractor 
		repository NewsRepository 
		wait_time 10
	end

	pool do # you can add more poolers
		sources "https://www.sensacionalista.com.br/feed/"
		extractor SensacionalistaExtractor 
		repository NewsRepository 
		wait_time 10
	end
end

