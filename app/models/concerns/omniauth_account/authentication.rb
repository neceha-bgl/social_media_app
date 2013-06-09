class OmniauthAccount 
	module Authentication
		extend ActiveSupport::Concern
		
		included do
		end
		
		module ClassMethods

      def create_with_auth(auth, user = nil)
        OmniauthAccount.create  do |omniauth_account|
          omniauth_account.user = user
          omniauth_account.provider = auth.provider
          omniauth_account.uid = auth.uid
          omniauth_account.token = auth.credentials.token
          omniauth_account.secret = auth.credentials.secret
          omniauth_account.expires_at = Time.at(auth.credentials.expires_at) unless auth.credentials.expires_at.nil?
        end
      end

      def find_by_auth(auth)
        omniauth_account = OmniauthAccount.where(auth.slice(:provider, :uid)).first
        omniauth_account.refresh_credentials auth if omniauth_account
      end

      def find_or_create_by_auth(auth, user = nil)
        find_by_auth(auth) || create_with_auth(auth, user)
      end

    end
	end

  def refresh_credentials auth
    return self if auth.credentials.nil?
    self.token = auth.credentials.token
    self.secret = auth.credentials.secret
    self.expires_at = Time.at(auth.credentials.expires_at) unless auth.credentials.expires_at.nil?
    save!
    self
  end

  def valid_token?
    return true if self.expires_at.nil?
    self.expires_at > Time.now
  end
end
