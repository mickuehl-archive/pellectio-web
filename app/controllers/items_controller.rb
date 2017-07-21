
class ItemsController < ApplicationController

	def show
		@region = params[:region]
		@asin = params[:asin]

		@results = ItemService.new.lookup @asin, @region
		if @results.empty?
			redirect_to root_path
		else
			@affiliate_link = "#{ENV['base_url']}/a/#{@region}/#{@asin}"
			@related = @results['related']
		end

	end

	def affiliate
		user_agent = request.env['HTTP_USER_AGENT']
		remote_addr = request.env['REMOTE_ADDR']
		region = params[:region]
		asin = params[:asin]

		@results = ItemService.new.lookup asin, region

		if is_web_crawler? user_agent
			# do not redirect, its FB, LinkedIn etc scraping !
			@related = @results['related']
			render :show
		else
			#if Rails.env.production?
			#	AnalyticsEventJob.perform_async(ENV['ga_property_id'], 'affiliate', 'redirect', "#{region}/#{asin}", @results['price'] / 100, session.id, user_agent, remote_addr)
			#end

			affiliate_url = "#{ENV['backend_api_url']}/a/#{region}/#{asin}"
			redirect_to affiliate_url
		end

	end

private

	#  LinkedInBot/1.0
	# facebookexternalhit/1.1
	def is_web_crawler?(user_agent)
		return true if user_agent.start_with? 'facebook'
		return true if user_agent.start_with? 'LinkedInBot'
		false
	end

end
