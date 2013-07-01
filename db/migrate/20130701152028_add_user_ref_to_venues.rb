class AddUserRefToVenues < ActiveRecord::Migration
  def change
    change_table :venues do |t|
      t.references :user
    end
  end
end
