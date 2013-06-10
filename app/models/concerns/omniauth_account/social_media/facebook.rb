class OmniauthAccount
	module SocialMedia::Facebook 
		extend ActiveSupport::Concern
		
		included do
		end

    private

    def social_media_facebook_profile(options = {})
      social_media_facebook_client.get_object("me")
    end

	  def social_media_facebook_client
      @social_media_facebook_client = Koala::Facebook::API.new(token)
    end

	end
end

