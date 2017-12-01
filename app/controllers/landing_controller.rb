
class LandingController < ApplicationController

	def index
		@q = nil
		@feed = FeedService.new.feed('book',1,18)
	end

end
