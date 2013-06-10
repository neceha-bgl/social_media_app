class OmniauthAccount
	module SocialMedia::Facebook 
		extend ActiveSupport::Concern
		
		included do
		end

    private

    def social_media_facebook_profile(options = {})
      @social_media_facebook_profile ||= social_media("facebook", "profile", options) do 
        social_media_facebook_client.get_object("me")
      end
    end

    def social_media_facebook_picture(options = {})
      @social_media_facebook_picture ||= social_media("facebook", "picture", options) do 
        social_media_facebook_client.get_picture("me")
      end
    end

    def social_media_facebook_friends(options = {})
      options = {who: "me"}.merge(options)
      @social_media_facebook_friends ||= social_media("facebook", "friends", options) do 
        social_media_facebook_client.get_connections(options[:who], "friends")
      end
    end

    def social_media_facebook_mutualfriends(friend_id, options = {})
      options = {who: "me"}.merge(options)
      social_media("facebook", "mutualfriends/#{friend_id}", options) do 
        social_media_facebook_client.get_connections(options[:who], "mutualfriends/#{friend_id}")
      end
    end

	  def social_media_facebook_client
      @social_media_facebook_client = Koala::Facebook::API.new(token)
    end

	end
end

