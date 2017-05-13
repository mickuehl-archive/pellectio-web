
#require 'elasticsearch'

class SearchService
	attr_reader :client

	def initialize
		#@client = Elasticsearch::Client.new url: ENV['elasticsearch_url'], log: true
	end

	def search_amazon(query)
		results = []

		puts "search_amazon: #{query}"

		return results
	end

end
