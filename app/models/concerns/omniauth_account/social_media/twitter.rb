class OmniauthAccount
	module SocialMedia::Twitter
    extend ActiveSupport::Concern
		
		included do
		end

    private

    def social_media_twitter_profile(options = {})
      @social_media_twitter_profile ||= social_media("twitter", "profile", options) do
        social_media_twitter_client.user
      end
    end

    def social_media_twitter_friends(options = {})
      @social_media_twitter_friends ||= social_media("twitter", "friends", options) do 
        social_media_twitter_client.friends
      end
    end

    def social_media_twitter_followers(options = {})
      @social_media_twitter_followers ||= social_media("twitter", "followers", options) do 
        social_media_twitter_client.followers
      end
    end

	  def social_media_twitter_client
      @social_media_twitter_client ||= Twitter::Client.new(
        :oauth_token => token,
        :oauth_token_secret => secret
      )
    end
 	end
end

