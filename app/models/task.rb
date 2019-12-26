class Task < ApplicationRecord
  has_many :taggings
  has_many :tags, through: :taggings, dependent: :delete_all
  belongs_to :user
  include AASM
  paginates_per 5
  validates :user_id, presence: true
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
  # 參考來源：https://www.spreered.com/rails-tagging-using-select2/
  # 可以用 Post.tagge_with(tagname) 來找到文章
  def self.tagged_with(name)
    Tag.find_by!(name: name).tasks
  end

  # 如果要取用 tag_list，可以加上這個 getter
  def tag_list
    tags.map(&:name).join(', ')
  end

  # tag_list 的 setter
  def tag_list=(names)
    self.tags = names.split(',').map do |item|
      Tag.where(name: item.strip).first_or_create!
    end
  end

  # tag_items 的 getter
  def tag_items
    tags.map(&:name)
  end

  # tag_items 的 setter
  def tag_items=(names)
    self.tags = names.map{ |item| Tag.where(name: item.strip).first_or_create! unless item.blank?}.compact!
  end
end