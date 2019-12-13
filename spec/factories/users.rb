FactoryBot.define do
  factory :user do
    username { Faker::TvShows::Friends.character }
    email { Faker::Internet.email }
    password_digest { "123456" }
  end
end

# create_table "tasks", force: :cascade do |t|
#   t.string "title"
#   t.text "content"
#   t.datetime "task_begin"
#   t.datetime "task_end"
#   t.integer "priority"
#   t.integer "status"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.bigint "user_id"
#   t.index ["status"], name: "index_tasks_on_status"
#   t.index ["title"], name: "index_tasks_on_title"
#   t.index ["user_id"], name: "index_tasks_on_user_id"
# end

# create_table "users", force: :cascade do |t|
#   t.string "username"
#   t.string "email"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.string "password_digest"
# end

# add_foreign_key "tasks", "users"
