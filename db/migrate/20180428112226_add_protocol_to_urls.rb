class AddProtocolToUrls < ActiveRecord::Migration
  def change
    add_column :urls, :protocol, :string
  end
end
