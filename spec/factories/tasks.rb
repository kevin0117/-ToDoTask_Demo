FactoryBot.define do
  factory :task do
    title { Faker::Job.title }
    content { Faker::Lorem.sentences }
    task_begin { Faker::Time.backward(days: 14, period: :evening) }
    task_end { Faker::Time.forward(days: 23, period: :morning) }
    priority { Faker::Number.between(from: 1, to: 3) }
    status { Faker::Number.between(from: 1, to: 3)  }
    
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
# end
