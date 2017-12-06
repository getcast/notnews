require 'feedjira'
require 'nokogiri'

class HoleExtractor < Extractor

	def initialize
	end


	def verify(url)
		return true
	end

	def extract(source)
		xml = Feedjira::Feed.connection(source).get.body	
		feed = Feedjira::Feed.parse_with(Feedjira::Parser::RSS, xml)
		feedEnum = []
		feed.entries.each do |entry|
			url = entry.url
			title = entry.title
			published = entry.published
		
			html = Feedjira::Feed.connection(url).get.body
			page = Nokogiri::HTML(html)
			image = page.css("meta[property='og:image']").first['content']
			
			f = {}
			f[:url] = url
			f[:title] = title
			f[:published] = published
			f[:image] = image	
			f[:source] = source 
			feedEnum << f
		
		feedEnum
	end

end
