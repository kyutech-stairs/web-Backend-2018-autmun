class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.text :text, null: false
      t.integer :user_id
      t.timestamps
    end
    add_foreign_key :tweets, :users
  end
end
