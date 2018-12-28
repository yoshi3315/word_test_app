# frozen_string_literal: true

class ChangeColumnRememberOfUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :remember_digest, :string, comment: '暗号化記憶トークン'
  end
end
