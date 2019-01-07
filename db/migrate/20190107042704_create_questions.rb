class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions, comment: '単語マスタ' do |t|
      t.string :question, comment: '単語'
      t.text :description, comment: '和訳'

      t.timestamps
    end
  end
end
