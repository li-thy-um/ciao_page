class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.string :author
      t.text :content

      t.timestamps null: false
    end
  end
end
