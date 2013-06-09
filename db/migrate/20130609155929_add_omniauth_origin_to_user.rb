class AddOmniauthOriginToUser < ActiveRecord::Migration
  def change
    add_column :users, :omniauth_origin, :boolean
  end
end
