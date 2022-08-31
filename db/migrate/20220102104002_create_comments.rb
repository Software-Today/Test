class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :answer, null: false, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
