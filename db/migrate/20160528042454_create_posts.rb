class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      
      t.string :title
      t.text :content
      t.string :contact
      t.string :price
      t.integer :user_id
      t.string :image_url, :default => ""
      
      t.timestamps null: false
    end
  end
end
