# frozen_string_literal: true

class ChangeColumnHighestRateToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :highest_rate, :integer, comment: '単語帳最高正解率'
  end
end
