
class SitemapController < ApplicationController

	layout nil

	def index
		headers['Content-Type'] = 'text/plain'

		@feed = FeedService.new.feed('book',1,100)

		sitemap = ""
		@feed.each do |feed|
			sitemap = sitemap + "#{ENV['base_url']}/i/#{feed['region']}/#{feed['asin']}\n"
		end

		render plain: sitemap
  end

end
