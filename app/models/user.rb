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
#  highest_rate    :integer                                # 単語帳最高正解率
#

class User < ApplicationRecord
  attr_accessor :remember_token

  validates :name, presence: true,
                   length: { maximum: 50 },
                   uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true,
                       length: { minimum: 6 },
                       allow_nil: true

  before_save :downcase_name

  scope :top_rankers, -> { where.not(highest_rate: nil).order('highest_rate desc').limit(10) }

  class << self
    def digest(string)
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update name: name, remember_digest: User.digest(remember_token)
  end

  def forget
    update name: name, remember_digest: nil
  end

  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  private

  def downcase_name
    name.downcase!
  end
end
