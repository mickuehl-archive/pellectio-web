
require 'open/open'

class SearchService < OpenSaas::SearchService

protected

		def finalize_results(response)
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
