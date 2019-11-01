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

RSpec.describe Task, type: :model do
  describe "Task Information" do
    it "Input fields are filled in" do
      task = Task.new(title: "Shopping", 
                      content: "buy apple", 
                      task_begin: "2019-11-01 09:00:00",
                      task_end: "2019-11-01 00:00:00",
                      priority: "urgent",
                      status: "pending")
      expect(task).to be_valid
    end

    it "task title is empty" do
      task = Task.new
      expect(task).not_to be_valid
    end          
  end
end