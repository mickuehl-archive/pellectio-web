
class ItemsController < ApplicationController

	def show
		@region = params[:region]
		@asin = params[:asin]

		@results = ItemService.new.lookup @asin, @region
		@related = @results[0][:details]['related_products']
		@features = @results[0][:details]['feature']
		#puts "#{@results}"
	end

	def affiliate
		puts "#{request.env['HTTP_HOST']}"
		puts "#{request.env['HTTP_USER_AGENT']}"

		region = params[:region]
		asin = params[:asin]

		affiliate_url = "https://www.amazon.de/dp/#{asin}/?tag=#{ENV['amzn_partner_id']}"
		redirect_to affiliate_url

	end

end
