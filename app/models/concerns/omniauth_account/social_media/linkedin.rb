class OmniauthAccount
	module SocialMedia::Linkedin 
		extend ActiveSupport::Concern
		
		included do
		end

    private

    def social_media_linkedin_profile(options = {})
      @profile ||= social_media("linkedin", "profile", options) do 
        social_media_linkedin_client.profile
      end
    end
    
    def social_media_linkedin_friends(options = {})
      @friends ||= social_media("linkedin", "friends", options) do 
        social_media_linkedin_client.connections
      end
    end

	  def social_media_linkedin_client
      return @social_media_linkedin_client if @social_media_linkedin_client 
      @social_media_linkedin_client = LinkedIn::Client.new
      @social_media_linkedin_client.authorize_from_access(token, secret)
      @social_media_linkedin_client
    end

	end
end

