Application.config do
	pool do # example 1
		sources "mysource1", "mysource2" # Sources list
		extractor ExtractorClassA        # Extractor
		repository RepositoryClassB      # Repository
	end

	pool do # you can add more poolers
		sources "another"
		extractor ExtractorClassC
		repository RepositoryClassD
		subscribers SubscriberClassE   # optional
		wait_time 500                  # optional, default: 300. (in seconds)     
	end
end

Database.config('postgres://mosaic:marvelouspandaband@localhost/mosaic') do
	create_table?(:photos) do  # example
		primary_key :id,
		String :url, null: false
		DateTime :date_added, null: false, default: Sequel::CURRENT_TIMESTAMP
	end
end