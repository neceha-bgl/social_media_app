class AddGmapFieldToVenue < ActiveRecord::Migration
  def change
    add_column :venues, :gmaps, :boolean
  end
end
