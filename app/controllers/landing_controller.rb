
require 'open/open'

class LandingController < ApplicationController

	def index
		@q = nil
	end

	def search

		if params[:search]
      @q = params[:search][:query]
			q = URI.encode( cleanup_query(@q))
			@q = nil if @q == ''
    else
      @q = nil
			q = ""
    end

		@results = OpenSaas::SearchService.new.search q, {region: 'DE', p: 1}

	end

	def subscribe
		subscription = Subscription.new(params.require(:subscription).permit(:email))
		begin
			if subscription.valid?
				MailingListSubscriptionJob.perform_async(subscription)
				# TODO maybe a nice confirmation dialog
	      #redirect_to root_path, notice: "Signed up #{@visitor.email}."
			else
				puts "+++ OOOPS +++"
	    end
		rescue => e
			puts "+++ E #{e}"
			# FIXME maybe some error handling
			#redirect_to root_path, error: "A user with the email '#{@visitor.email}' alraedy exists."
		end

		redirect_to root_path
	end

private

	def cleanup_query(s)
		s.gsub!(' ','+')
		s
	end

end
