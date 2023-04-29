class CreateShortUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :short_urls do |t|
      t.string :original_url
      t.string :short_code
      t.references :user, index: true

      t.timestamps
    end
    add_index :short_urls, :short_code
  end
end
