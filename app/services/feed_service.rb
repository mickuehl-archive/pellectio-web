
require 'open/open'

class FeedService

	attr_reader :connection

	def initialize
		@connection = OpenSaas::Connection.new(ENV['backend_api_url'], {})
	end

	def feed(feed, page, size)

		begin
			response = @connection.get("/feed?s=book&p=#{page}&n=#{size}", {}, :body => nil)
			#finalize_response response
			return response
		rescue => e
			[]
		end

	end

protected

	def finalize_response(response)
		results = []

		response.each do |r|
			results << r
		end

		puts "#{results}"
	end

end
