# frozen_string_literal: true

# == Schema Information
#
# Table name: questions # 単語マスタ
#
#  id          :bigint(8)        not null, primary key
#  question    :string                                 # 単語
#  description :text                                   # 和訳
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Question < ApplicationRecord
  has_many :question_similar_words, dependent: :destroy, inverse_of: :question
  accepts_nested_attributes_for :question_similar_words,
                                reject_if: :all_blank,
                                allow_destroy: true

  with_options presence: true do
    validates :question
    validates :description
  end
end
