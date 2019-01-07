# == Schema Information
#
# Table name: question_similar_words # 類義語テーブル
#
#  id           :bigint(8)        not null, primary key
#  question_id  :integer                                # 単語id
#  similar_word :string                                 # 類義語
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class QuestionSimilarWord < ApplicationRecord
  belongs_to :question
end
