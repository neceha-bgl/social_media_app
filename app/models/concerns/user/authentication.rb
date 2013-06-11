class User
	module Authentication
		extend ActiveSupport::Concern
		
		included do
		end
		
		module ClassMethods

			def find_with_auth(auth)
				omniauth_account = OmniauthAccount.find_or_create_by_auth auth
				return omniauth_account.user if omniauth_account.user 
				user = create do |u|
					u.user_name = auth.info.nickname
					u.first_name = auth.info.first_name
					u.last_name = auth.info.last_name
					u.email = auth.info.email || "#{auth.info.nickname}@socialmediaapp.com"
					u.omniauth_origin = true
					u.omniauth_accounts << omniauth_account
				end
				[user , omniauth_account]
			end
			
			def new_with_session(params, session)
				if session["devise.user_attributes"] && session["devise.omniauth_account_id"]
					omniauth_account = OmniauthAccount.find_by_id session["devise.omniauth_account_id"]
					new(session["devise.user_attributes"], without_protection: true) do |user|
						user.attributes = params
						user.valid?
						user.omniauth_accounts << omniauth_account
					end
				else
					super
				end
			end
		end

    def has_provider? provider
			providers.include? provider
		end
    
    def get_omniauth_account_by_provider provider
      omniauth_accounts.find_by_provider provider
    end

		def providers
			omniauth_accounts.inject([]) do |result , omniauth_account|
				result << omniauth_account.provider.to_sym
			end
		end
		
		def add_omniauth_account(auth)
			OmniauthAccount.find_or_create_by_auth(auth, self)
		end
		
		def update_with_password(params, *options)
			if encrypted_password.blank?
				update_attributes(params, *options)
			else
				super
			end
		end

    def created_omniauth_origin?
      omniauth_origin
    end

	end
end

