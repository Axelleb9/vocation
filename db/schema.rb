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

ActiveRecord::Schema.define(version: 2019_09_05_134204) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "lists", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "switch", default: true
    t.integer "week"
    t.boolean "quizz_done", default: false
    t.boolean "flashcard_done"
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "meanings", force: :cascade do |t|
    t.bigint "word_id"
    t.string "nou", array: true
    t.string "vrb", array: true
    t.string "adj", array: true
    t.string "adv", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["word_id"], name: "index_meanings_on_word_id"
  end

  create_table "quizz_questions", force: :cascade do |t|
    t.bigint "words_list_id"
    t.string "good_answer"
    t.string "wrong_answers", array: true
    t.integer "question_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["words_list_id"], name: "index_quizz_questions_on_words_list_id"
  end

  create_table "references", force: :cascade do |t|
    t.bigint "word_id"
    t.string "broad_terms", array: true
    t.string "narrow_terms", array: true
    t.string "related_terms", array: true
    t.string "synonyms", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["word_id"], name: "index_references_on_word_id"
  end

  create_table "user_words", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "word_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "state"
    t.index ["user_id"], name: "index_user_words_on_user_id"
    t.index ["word_id"], name: "index_user_words_on_word_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", id: :serial, force: :cascade do |t|
    t.string "votable_type"
    t.integer "votable_id"
    t.string "voter_type"
    t.integer "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  end

  create_table "words", force: :cascade do |t|
    t.string "entry"
    t.string "translation"
    t.text "definition", array: true
    t.text "example"
    t.string "nature", array: true
    t.integer "difficulty"
    t.string "synonyms", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "visible", default: false
    t.string "state"
  end

  create_table "words_lists", force: :cascade do |t|
    t.bigint "word_id"
    t.bigint "list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "reviewed"
    t.boolean "quizz_status", default: false
    t.index ["list_id"], name: "index_words_lists_on_list_id"
    t.index ["word_id"], name: "index_words_lists_on_word_id"
  end

  add_foreign_key "lists", "users"
  add_foreign_key "meanings", "words"
  add_foreign_key "quizz_questions", "words_lists"
  add_foreign_key "references", "words"
  add_foreign_key "user_words", "users"
  add_foreign_key "user_words", "words"
  add_foreign_key "words_lists", "lists"
  add_foreign_key "words_lists", "words"
end
