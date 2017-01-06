class MailChimpSubscriptionWorker
  include Sidekiq::Worker

  def perform(email)
    gibbon = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'])
    gibbon.lists(ENV['MAILCHIMP_KL_MEETUPS_LIST_ID'])
          .members(Digest::MD5.hexdigest(email.downcase))
          .upsert(
            body: {
              email_address: email.downcase,
              status: 'subscribed'
            }
          )
  end
end
