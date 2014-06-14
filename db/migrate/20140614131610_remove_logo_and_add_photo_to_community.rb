class RemoveLogoAndAddPhotoToCommunity < ActiveRecord::Migration
  def change
  	remove_column :communities, :logo, :string
  	add_column    :communities, :photo, :string
  end
end
