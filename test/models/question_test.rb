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


require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
