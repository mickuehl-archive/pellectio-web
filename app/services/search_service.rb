
require 'open/open'

class SearchService

	attr_reader :connection

	def initialize
		@connection = OpenSaas::Connection.new(ENV['backend_api_url'], {})
	end

	def search(query, opts = {})

		params = ""
		opts.each do |n,v|
			params << "&#{n}=#{v}"
		end

		begin
			response = @connection.get("/search?q=#{query}#{params}", {}, :body => nil)
			finalize_response response
		rescue => e
			[]
		end

	end

protected

	#
	# item = {
	# 	id: r['asin'],
	# 	title: r['title'],
	# 	summary: r['summary'],
	# 	relevance: 1.0,
	# 	images: [{url: 'link to image', height: 75, width: 56}],
	#   details: { a: 'A', b: 'B'}
	# }
	#
	def finalize_response(response)
		results = []

		response.each do |r|
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

		results
	end

end
