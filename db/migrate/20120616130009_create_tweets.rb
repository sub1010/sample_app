class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :belng_to
      t.string :tweet_text
      t.integer :likes

      t.timestamps
    end
  end
end
