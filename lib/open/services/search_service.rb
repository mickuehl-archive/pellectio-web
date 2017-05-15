
require 'open/open'

module OpenSaas

	class SearchService
		attr_reader :connection
		attr_reader :search_uri

		def initialize
			@connection = OpenSaas::Connection.new(ENV['backend_api_url'], {})
			@search_uri = ENV['backend_search_uri']
		end

		def search(query, opts = {})
			results = []

			params = ""
			opts.each do |n,v|
				params << "&#{n}=#{v}"
			end

			result = @connection.get("#{@search_uri}?q=#{query}#{params}", {}, :body => nil)

			result.each do |r|
				item = {
					id: r['asin'],
					title: r['title'],
					summary: r['summary'],
					relevance: 1.0,
					images: r['images'],
				}
				r.delete('images')

				details = {}
				r.each do |k,v|
					details[k] = v
				end
				item[:details] = details

				results << item
			end

			return results
		end

	end

end
