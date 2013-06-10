class OmniauthAccount 
	module SocialMedia
		extend ActiveSupport::Concern
		
		included do
      include SocialMedia::Facebook
		end

    def method_missing(id,*args,&block)
      case(id.to_s)
      when /^social_media_(.*)/
        send("social_media_#{provider}_#{$1}",*args,&block)
      else
        super
      end
    end
	end
end
