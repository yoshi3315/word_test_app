class RegenerateUsers < ActiveRecord::Migration[5.2]
  def change
    drop_table :users

    create_table :users, comment: 'ユーザーテーブル' do |t|
      t.string :name, comment: 'ユーザーID'
      t.string :password_digest, comment: '暗号化パスワード'

      t.timestamps
    end
  end
end
