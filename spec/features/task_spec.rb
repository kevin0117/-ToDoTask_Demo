# create_table "tasks", force: :cascade do |t|
#   t.string "title"
#   t.text "content"
#   t.datetime "task_begin"
#   t.datetime "task_end"
#   t.integer "priority"
#   t.string "status"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end

require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  scenario "Adding a new task" do
    visit '/tasks/new'

    fill_in "task_title", with: "Shopping"
    fill_in "task_content", with: "buy milk"
    fill_in "task_task_begin", with: "2019-11-01 09:00:00"
    fill_in "task_task_end", with: "2019-11-01 00:00:00"
    choose "task[priority]", with: "medium"
    choose "task[status]", with: "pending"

    click_button "新增"

    expect(page).to have_text("任務已建立")
  end
end
