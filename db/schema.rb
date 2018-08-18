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

ActiveRecord::Schema.define(version: 2018_08_14_213711) do

  create_table "answers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "ticket_id"
    t.text "answer"
    t.integer "status", limit: 1, default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_answers_on_ticket_id"
  end

  create_table "children", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "contato"
    t.date "nascimento"
    t.string "responsavel"
    t.integer "parentesco", limit: 1
    t.integer "sexo", limit: 1
    t.integer "status", limit: 1, default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_children_on_user_id"
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "acao", limit: 1
    t.integer "periodo", limit: 1
    t.text "message_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "monitor_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "login"
    t.string "name"
    t.integer "level", default: 1
    t.bigint "user_id"
    t.string "password_digest"
    t.integer "access_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_monitor_users_on_user_id"
  end

  create_table "sms_messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "monitor_user_id"
    t.bigint "child_id"
    t.integer "periodo", limit: 1
    t.integer "acao", limit: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id"], name: "index_sms_messages_on_child_id"
    t.index ["monitor_user_id"], name: "index_sms_messages_on_monitor_user_id"
  end

  create_table "tickets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", default: 1
    t.integer "status", limit: 1, default: 1
    t.string "title"
    t.text "notification"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "login"
    t.string "contato"
    t.integer "level", default: 2
    t.integer "access_count", default: 0
    t.integer "status", limit: 1, default: 1
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "answers", "tickets"
  add_foreign_key "children", "users"
  add_foreign_key "messages", "users"
  add_foreign_key "monitor_users", "users"
  add_foreign_key "sms_messages", "children"
  add_foreign_key "sms_messages", "monitor_users"
  add_foreign_key "tickets", "users"
end
