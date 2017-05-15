
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

			params = ""
			opts.each do |n,v|
				params << "&#{n}=#{v}"
			end

			response = @connection.get("#{@search_uri}?q=#{query}#{params}", {}, :body => nil)

			finalize_results response

		end

protected

		def finalize_results(response)
			results = []

			response.each do |r|
				results << r
			end

			results
		end

	end

end
