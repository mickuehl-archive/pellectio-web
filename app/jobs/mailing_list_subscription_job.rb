
class MailingListSubscriptionJob
  include SuckerPunch::Job

  def perform(subscription)

    begin
      mailchimp = Gibbon::Request.new(api_key: ENV['mailchimp_api_key'])
      list_id = ENV['mailchimp_list_id']
      result = mailchimp.lists(list_id).members.create(
        body: {
          email_address: subscription.email,
          status: 'subscribed'
      })
    rescue Gibbon::MailChimpError => e
      puts "#{e.raw_body}"
      # FIXME error handling !!!!
    end

  end

end
