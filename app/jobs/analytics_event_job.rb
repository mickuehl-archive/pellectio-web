
require 'excon'

class AnalyticsEventJob
  include SuckerPunch::Job

  def perform(propertyId, category, action, label, value, uuid, user_agent, remote_addr)

    return if !Rails.env.production?
    
    begin

      payload = {
        #:v => '1',
        :tid => propertyId,
        :ds => 'app',
        #:geoid => 'region'
        #:ul => 'language',
        :cid => uuid,
        :t => 'event',
        :ec => category,
        :ea => action,
        :ua => URI.encode(user_agent),
        :el => label,
        :ev => value,
        :uip => URI.encode(remote_addr),
      }

      params = ""
  		payload.each do |n,v|
  			params << "&#{n}=#{v}"
  		end

      response = Excon.new('https://www.google-analytics.com').post(path: "/collect?v=1#{params}")

    rescue => e
      puts "#{e.raw_body}"
      # FIXME error handling !!!!
    end

  end

end
