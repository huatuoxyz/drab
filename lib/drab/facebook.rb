require 'oauth'
require 'facebook_oauth'
#require 'openssl'
#OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
#require 'net/https'

def facebook_client(token=nil)
  FacebookOAuth::Client.new(
   :application_id => self.config[:consumer_facebook_id],
   :application_secret => self.config[:consumer_facebook_secret],
   :callback => self.config[:consumer_facebook_redirect_url],
   :token => token
  )
end
