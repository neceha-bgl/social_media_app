class OmniauthAccount
	module SocialMedia::Viadeo 
		extend ActiveSupport::Concern
		
		included do
		end

    private

    def social_media_viadeo_profile(options = {})
      @profile ||= social_media("viadeo", "profile", options) do 
        Viadeo::User.new(token).retrieve
      end
    end

    def social_media_viadeo_friends(options = {})
      @friends ||= social_media("viadeo", "friends", options) do 
       Viadeo::User.new(token, connection: "contacts").retrieve(limit: 100)
      end
    end

    def social_media_viadeo_groups(options = {})
      @groups ||= social_media("viadeo", "groups", options) do 
       Viadeo::User.new(token, connection: "groups").retrieve(limit: 100)
      end
    end

	end
end

