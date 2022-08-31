class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :title
      t.text :body, null: false
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
