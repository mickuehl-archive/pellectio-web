
class ItemsController < ApplicationController

	def show
		@region = params[:region]
		@asin = params[:asin]

		@results = ItemService.new.lookup @asin, @region
		if @results.empty?
			redirect_to root_path
		else
			@related = @results[0][:details]['related_products']
			@features = @results[0][:details]['feature']
		end

	end

	def affiliate
		user_agent = request.env['HTTP_USER_AGENT']
		remote_addr = request.env['REMOTE_ADDR']
		region = params[:region]
		asin = params[:asin]

		if user_agent.start_with? 'facebook'
			# do not redirect, its FB scraping !
			@results = ItemService.new.lookup asin, region
			@related = @results[0][:details]['related_products']
			@features = @results[0][:details]['feature']

			render :show
		else
			affiliate_url = "https://www.amazon.de/dp/#{asin}/?tag=#{ENV['amzn_partner_id']}"
			redirect_to affiliate_url

			AnalyticsEventJob.perform_async(ENV['ga_property_id'], 'affiliate', 'redirect', "#{region}/#{asin}", 1, session.id, user_agent, remote_addr)
		end

	end

end
