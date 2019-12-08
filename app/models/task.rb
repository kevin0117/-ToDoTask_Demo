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

class Task < ApplicationRecord
  include AASM
  paginates_per 5
  validates :title, presence: true
  validates :content, length: {maximum: 500}, presence: true
  validates :task_begin, presence: true  #基本驗證，步驟12要改為 task_begin < task_end
  validates :task_end, presence: true    #基本驗證，步驟12要改為 task_begin < task_end
  validates :priority, presence: true
  validates :status, presence: true
  validate :date_validator
  enum priority: { low: 1, medium: 2, urgent:3 }
  enum status: { pending: 1, proceeding: 2, done:3 }

  aasm column: 'status', enum: true do
    state :pending, initial: true
    state :proceeding, :done

    event :proceed do
      transitions from: :pending, to: :proceeding
    end

    event :finish do
      transitions from: :proceeding, to: :done
    end
  end

  def date_validator
    if (self.task_begin == nil) || (self.task_end == nil)
      errors.add(:task, " begin 不能為空白")
    elsif self.task_begin >= self.task_end
      # puts "-------------------------"
      # puts self.task_begin.inspect
      # puts self.task_end.inspect
      # puts "--------------------------"
      errors.add(:task, "任務結束日期不能比開始日期早")
    end
  end
end