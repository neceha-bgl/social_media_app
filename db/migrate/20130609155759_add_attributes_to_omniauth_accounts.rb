class AddAttributesToOmniauthAccounts < ActiveRecord::Migration
  def change
    add_column :omniauth_accounts, :provider, :string
    add_column :omniauth_accounts, :uid, :string
    add_column :omniauth_accounts, :token, :string
    add_column :omniauth_accounts, :expires_at, :datetime
    add_column :omniauth_accounts, :secret, :string
    add_column :omniauth_accounts, :user_id, :integer
  end
end
