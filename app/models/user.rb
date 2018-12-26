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
#

class User < ApplicationRecord
  validates :name, presence: true,
                   length: { maximum: 50 },
                   uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true,
                       length: { minimum: 6 },
                       allow_nil: true
end
