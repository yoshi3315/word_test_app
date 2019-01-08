# frozen_string_literal: true

class CreateQuestionSimilarWords < ActiveRecord::Migration[5.2]
  def change
    create_table :question_similar_words, comment: '類義語テーブル' do |t|
      t.integer :question_id, comment: '単語id'
      t.string :similar_word, comment: '類義語'

      t.timestamps
    end
  end
end
