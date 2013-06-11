class OmniauthAccount 
	module SocialMedia
		extend ActiveSupport::Concern
		
		included do
      include SocialMedia::Facebook
      include SocialMedia::Linkedin
      include SocialMedia::Viadeo
      include SocialMedia::Twitter
		end

    def social_media(api, rubrique, options, &block)
      logger.debug "Make social media request"
      options = default_options.merge(options)
      return MultiJson.load(MultiJson.dump(yield)) unless options[:cache]
      return read_cache(api, rubrique, &block) unless options[:refresh_cache]
      write_cache(api, rubrique, &block)
    end

    def read_cache(api, rubrique, &block)
      cache = $redis.get("#{api}_omniauth_account_#{id}_#{rubrique}")
      return write_cache(api, rubrique, &block) unless cache
      MultiJson.load(cache)
    end

    def write_cache(api, rubrique, &block)
      logger.debug "Write result on cache"
      data = MultiJson.dump(block.call)
      $redis.set("#{api}_omniauth_account_#{id}_#{rubrique}",data)
      return  MultiJson.load(data)
    end

    def default_options
      {cache: true, refresh_cache: false}
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
