class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :museum, null: false, foreign_key: true
      t.string :rating
      t.string :content

      t.timestamps
    end
  end
end
