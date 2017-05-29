
require 'open/open'

class ItemService

	attr_reader :connection
	attr_reader :search_uri

	def initialize
		@connection = OpenSaas::Connection.new(ENV['inventory_api_url'], {})
	end

	def lookup(asin, region)

		begin
			return @connection.get("/item/#{region}/#{asin}", {}, :body => nil)
		rescue => e
			[]
		end

	end

end
