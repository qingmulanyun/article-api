class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.date :date, null: false, index: true
      t.text :body, null: false
      t.text :tags, array: true, default: []

      t.timestamps
    end

    # create an index for the array column
    add_index :articles, :tags, using: 'gin'
  end
end
