
class ItemsController < ApplicationController

	def show
		@region = params[:region]
		@asin = params[:asin]

		@results = ItemService.new.lookup @asin, @region
		if @results.empty?
			redirect_to root_path
		else
			@affiliate_link = "#{Rails.application.secrets.base_url}/a/#{@region}/#{@asin}"
			@related = @results['related']
		end

	end

	def affiliate
		user_agent = request.env['HTTP_USER_AGENT']
		remote_addr = request.env['REMOTE_ADDR']
		
		#puts "user_agent=#{user_agent}, remote_addr=#{remote_addr}"

		region = params[:region]
		asin = params[:asin]
		source = params[:s]
		source = "wb" if (source == "" || source == nil)

		@results = ItemService.new.lookup asin, region

		if is_web_crawler? user_agent
			# do not redirect, its FB, LinkedIn, Google etc scraping !
			@related = @results['related']
			render :show
		else
			affiliate_url = "#{Rails.application.secrets.backend_api_url}/a/#{region}/#{asin}?s=#{source}"
			redirect_to affiliate_url
		end

	end

private

	# LinkedInBot/1.0
	# facebookexternalhit/1.1
	# user_agent=Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)
	def is_web_crawler?(user_agent)
		return true if user_agent.start_with? 'facebook'
		return true if user_agent.start_with? 'LinkedInBot'
		return true if user_agent.include? 'Googlebot'
		false
	end

end
