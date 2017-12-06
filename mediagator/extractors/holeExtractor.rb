require 'feedjira'
require 'nokogiri'

class HoleExtractor < Extractor

	def initialize
		@repository = NewsRepository.new
	end

	private def connection(url, headers, request_options)
		Faraday.new(url: url, headers: headers, request: request_options) do |conn|
		  conn.use FaradayMiddleware::FollowRedirects, limit: Feedjira.follow_redirect_limit
		  conn.adapter Faraday.default_adapter
		end
	end

	def verify(source)
		lu = @repository.last_updated(source)
		if lu == nil
			return true
		end

		headers = {user_agent: Feedjira.user_agent, if_modified_since: lu.httpdate}
		request_options = {timeout: Feedjira.request_timeout}
		xml = connection(source, headers, request_options).get.body
		return (not xml.empty?)
	end

	def extract(source)
		lu = @repository.last_updated(source)
		
		headers = {user_agent: Feedjira.user_agent, if_modified_since: lu.httpdate}
		request_options = {timeout: Feedjira.request_timeout}
		xml = connection(source, headers, request_options).get.body
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
		end

		@repository.update_date(source)
		feedEnum

	end
end
