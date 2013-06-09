class CreateOmniauthAccounts < ActiveRecord::Migration
  def change
    create_table :omniauth_accounts do |t|

      t.timestamps
    end
  end
end
