require 'feedjira'
require 'nokogiri'

class OnionExtractor < Extractor

	def initialize
	end


	def verify(url)
		return true
	end

	def extract(url)
		xml = Feedjira::Feed.connection(url).get.body	
		feed = Feedjira::Feed.parse_with(Feedjira::Parser::RSS, xml)
		feedEnum = []
		feed.entries.each do |entry|
			url = entry.url
			title = entry.title
			published = entry.published
		
			html = Feedjira::Feed.connection(url).get.body
			page = Nokogiri::HTML(entry.summary)
			image = page.css("img").first['src']
			
			f = {}
			f[:url] = url
			f[:title] = title
			f[:published] = published
			f[:image] = image	
			feedEnum << f
		
		feedEnum
	end

end
