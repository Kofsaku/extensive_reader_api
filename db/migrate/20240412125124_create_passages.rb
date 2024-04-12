class CreatePassages < ActiveRecord::Migration[7.0]
  def change
    create_table :passages do |t|
      t.string :title
      t.text :content
      t.integer :difficulty
      t.integer :format
      t.integer :words_count
      t.integer :actual_words_count
      t.string :genre
      t.text :raw_generated_text

      t.timestamps
    end
  end
end
