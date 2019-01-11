# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_01_11_055017) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "question_similar_words", comment: "類義語テーブル", force: :cascade do |t|
    t.integer "question_id", comment: "単語id"
    t.string "similar_word", comment: "類義語"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", comment: "単語マスタ", force: :cascade do |t|
    t.string "question", comment: "単語"
    t.text "description", comment: "和訳"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", comment: "ユーザーテーブル", force: :cascade do |t|
    t.string "name", comment: "ユーザーID"
    t.string "password_digest", comment: "暗号化パスワード"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_digest", comment: "暗号化記憶トークン"
    t.integer "highest_rate", comment: "単語帳最高正解率"
  end

end
