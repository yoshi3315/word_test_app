# frozen_string_literal: true
# == Schema Information
#
# Table name: users # ユーザーテーブル
#
#  id              :bigint(8)        not null, primary key
#  name            :string                                 # ユーザーID
#  password_digest :string                                 # 暗号化パスワード
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  remember_digest :string                                 # 暗号化記憶トークン
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
