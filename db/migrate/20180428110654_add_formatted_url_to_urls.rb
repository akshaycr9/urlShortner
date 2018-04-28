class AddFormattedUrlToUrls < ActiveRecord::Migration
  def change
    add_column :urls, :formatted_url, :string
  end
end
