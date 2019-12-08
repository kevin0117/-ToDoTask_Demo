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
  describe '單元測試' do   
    subject { build(:task) }
 
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:task_begin) }
    it { should validate_presence_of(:task_end) }
    it { should validate_presence_of(:priority) }
    it { should validate_presence_of(:status) }

    it "任務建立失敗當開始時間設定空白" do
      task = Task.new(title: "Shopping", 
                      content: "buy apple", 
                      task_begin: "",
                      task_end: "Wed, 21 Nov 2019 19:06:00 CST +08:00",
                      priority: "urgent",
                      status: "pending")
        expect {
          expect(task).to be_valid
        }.to raise_exception(/Task begin 不能為空白/)
    end
    it "任務建立成功當全部欄位正確填寫完成" do
      task = Task.new(title: "Shopping", 
                      content: "buy apple", 
                      task_begin: "Wed, 21 Nov 2019 19:06:00 CST +08:00",
                      task_end: "Wed, 29 Nov 2019 19:06:00 CST +08:00",
                      priority: "urgent",
                      status: "pending")
      # task = create(:task)
      expect(task).to be_valid
    end

    it "任務建立失敗當結束時間設定錯誤" do
      # task = create(:task, 
      #               task_begin: "Wed, 25 Nov 2019 19:06:00 CST +08:00",
      #                 task_end: "Wed, 21 Nov 2019 19:06:00 CST +08:00" )
      task = Task.new(title: "Shopping", 
                      content: "buy apple", 
                      task_begin: "Wed, 25 Nov 2019 19:06:00 CST +08:00",
                      task_end: "Wed, 21 Nov 2019 19:06:00 CST +08:00",
                      priority: "urgent",
                      status: "pending")
        expect {
          expect(task).to be_valid
        }.to raise_exception(/Task 任務結束日期不能比開始日期早/)
    end

    before do
      task_1 =create(:task, title: "task_1")
      task_2 =create(:task, title: "task_2")
      task_3 =create(:task, title: "task_3")
    end 

    # it "任務建立失敗當結束時間設定錯誤" do

    #   # task = Task.new(title: "Shopping", 
    #   #                 content: "buy apple", 
    #   #                 task_begin: "Wed, 25 Nov 2019 19:06:00 CST +08:00",
    #   #                 task_end: "Wed, 21 Nov 2019 19:06:00 CST +08:00",
    #   #                 priority: "urgent",
    #   #                 status: "pending")
    #     expect {
    #       expect(task).to be_valid
    #     }.to raise_exception(/Task 任務結束日期不能比開始日期早/)
    # end
  end


end
  # describe "Task Information" do
  #   it "is valid with a title, content, task date, priority, and status" do
  #     task = Task.new(title: "Shopping", 
  #                     content: "buy apple", 
  #                     task_begin: "2019-11-01 09:00:00",
  #                     task_end: "2019-11-01 00:00:00",
  #                     priority: "urgent",
  #                     status: "pending")
  #     expect(task).to be_valid
  #   end

  #   it "title field is blank" do
  #     task = Task.new(title: "", 
  #                     content: "buy apple", 
  #                     task_begin: "2019-11-01 09:00:00",
  #                     task_end: "2019-11-01 00:00:00",
  #                     priority: "urgent",
  #                     status: "pending")
  #       expect {
  #         expect(task).to be_valid
  #       }.to raise_exception(/Title can't be blank/)
  #   end

  #   it "is invalid without a title" do
  #     task = Task.new(title: nil)
  #     task.valid?
  #     expect(task.errors[:title]).to include("can't be blank")
  #   end
    
  #   it "content field is blank" do
  #     task = Task.new(title: "Shopping", 
  #                     content: "", 
  #                     task_begin: "2019-11-01 09:00:00",
  #                     task_end: "2019-11-01 00:00:00",
  #                     priority: "urgent",
  #                     status: "pending")
  #       expect {
  #         expect(task).to be_valid
  #       }.to raise_exception(/Content can't be blank/)
  #   end
    
    # it "Task begin field is blank" do
    #   task = Task.new(title: "Shopping", 
    #                   content: "buy apple", 
    #                   task_begin: "",
    #                   task_end: "2019-11-01 00:00:00",
    #                   priority: "urgent",
    #                   status: "pending")
    #     expect {
    #       expect(task).to be_valid
    #     }.to raise_exception(/Task begin can't be blank/)
    # end
    
  #   it "Task end field is blank" do
  #     task = Task.new(title: "Shopping", 
  #                     content: "buy apple", 
  #                     task_begin: "2019-11-01 09:00:00",
  #                     task_end: "",
  #                     priority: "urgent",
  #                     status: "pending")
  #       expect {
  #         expect(task).to be_valid
  #       }.to raise_exception(/Task end can't be blank/)
  #   end
    
  #   it "priority field is blank" do
  #     task = Task.new(title: "Shopping", 
  #                     content: "buy apple", 
  #                     task_begin: "2019-11-01 09:00:00",
  #                     task_end: "2019-11-01 00:00:00",
  #                     priority: "",
  #                     status: "pending")
  #       expect {
  #         expect(task).to be_valid
  #       }.to raise_exception(/Priority can't be blank/)
  #   end
    
  #   it "status field is blank" do
  #     task = Task.new(title: "Shopping", 
  #                     content: "buy apple", 
  #                     task_begin: "2019-11-01 09:00:00",
  #                     task_end: "2019-11-01 00:00:00",
  #                     priority: "urgent",
  #                     status: "")
  #       expect {
  #         expect(task).to be_valid
  #       }.to raise_exception(/Status can't be blank/)
  #   end           
  # end
