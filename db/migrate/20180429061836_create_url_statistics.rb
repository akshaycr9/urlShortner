class CreateUrlStatistics < ActiveRecord::Migration
  def change
    create_table :url_statistics do |t|
      t.integer :same_url_converted, default: 0
      t.integer :url_opened, default: 0
      t.datetime :last_opened_at
      t.string :last_browser_opened_on
      t.integer :url_id

      t.timestamps null: false
    end
  end
end
