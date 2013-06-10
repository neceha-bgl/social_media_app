class OmniauthAccount
	module SocialMedia::Facebook 
		extend ActiveSupport::Concern
		
		included do
		end

    private

    def social_media_facebook_profile(options = {})
      social_media_facebook_client.get_object("me")
    end

    def social_media_facebook_picture(options = {})
      social_media_facebook_client.get_picture("me")
    end

    def social_media_facebook_friends(options = {})
      options = {who: "me"}
      social_media_facebook_client.get_connections(options[:who], "friends")
    end

    def social_media_facebook_mutualfriends(friend_id, options = {})
      options = {who: "me"}
      social_media_facebook_client.get_connections(options[:who], "mutualfriends/#{friend_id}")
    end

	  def social_media_facebook_client
      @social_media_facebook_client = Koala::Facebook::API.new(token)
    end

	end
end

