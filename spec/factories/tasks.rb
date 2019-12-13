FactoryBot.define do
  factory :task do
    title { Faker::TvShows::Friends.character }
    content { Faker::TvShows::Friends.quote }
    task_begin { Faker::Time.backward(days: 14, period: :evening) }
    task_end { Faker::Time.forward(days: 23, period: :morning) }
    priority { Faker::Number.between(from: 1, to: 3) }
    status { Faker::Number.between(from: 1, to: 3)  }
    user_id { Faker::Number.within(range: 23..27) }

    trait :complete do
      status { 3 }
    end

    trait :important do
      priority { 3 }
    end
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
