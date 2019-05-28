class CreateJokes < ActiveRecord::Migration[5.0]
  def change
      create_table :jokes do |t|
          t.string :punchline
          t.string :category
          t.string :setup
      end
  end
end
