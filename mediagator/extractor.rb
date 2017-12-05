class Extractor
	def verify(source)
		raise "not implemented"
	end

	def extract(source)
		raise "not implemented"
	end
end


# class PhotoExtractor < Extractor
#		def initialize(repositories)
#			@repositories = repositories
#		end

#		def verify(source)
#	 		date = most_recent(source).date
#			@repositories[source].each do |repository|
#				return true if repository.last_update < date
#			end
#			return false
#		end

#		def extract(source)
#			date = most_recent(source).date
#			data = all_since(date)
#		end
# end
