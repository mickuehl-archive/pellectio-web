
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
		#puts "#{request.env['HTTP_HOST']}"
		#puts "#{request.env['HTTP_USER_AGENT']}"
		user_agent = request.env['HTTP_USER_AGENT']
		region = params[:region]
		asin = params[:asin]

		if user_agent.start_with? 'facebook'
			affiliate_url = "#{ENV['base_url']}/i/#{region}/#{asin}"
		else
			affiliate_url = "https://www.amazon.de/dp/#{asin}/?tag=#{ENV['amzn_partner_id']}"
		end

		redirect_to affiliate_url

	end

end
