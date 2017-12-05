class Pooler
	def initialize(sources, extractor, repository, subscribers, time: 600)
		@sources = sources
		@extractor = extractor
		@repository = repository
		@subscribers = subscribers
		@time = time
	end

	def pool
		loop do 
			threads = []
			@sources.each do |source|
				t = Thread.new do
					if @extractor.verify(source)
						new_data = extractor.extract(source)
						@repository.batch_update(new_data)

						@subscribers.each do |subscribe|
							subscriber.notify(source, new_data)
						end
					end
				end

				t.run
				threads << t
			end
			
			threads.each do |t|
				t.join
			end
			sleep @time
		end
	end
end
