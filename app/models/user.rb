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

  before_save :downcase_name

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  private

    def downcase_name
      name.downcase!
    end

end
