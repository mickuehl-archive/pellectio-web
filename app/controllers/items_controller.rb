
class ItemsController < ApplicationController

	def show
		@region = params[:region]
		@asin = params[:asin]

		@results = ItemService.new.lookup @asin, @region
		@related = @results[0][:details]['related_products']
		@features = @results[0][:details]['feature']
		
		#puts "#{@results}"
	end

end
