class CreateFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :favorites do |f|
      f.integer :user_id
      f.integer :joke_id
    end
  end
end
