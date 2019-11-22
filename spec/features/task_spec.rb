require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  scenario "新增任務" do
    visit '/'

    click_button "新增任務"
    expect(current_path).to eq(new_task_path)

    fill_in "task_title", with: "Shopping"
    fill_in "task_content", with: "buy milk"
    select '2019', from: 'task_task_begin_1i'
    select '2019', from: 'task_task_end_1i'
    select '不急', from: 'task_priority'
    select '已完成', from: 'task_status'

    click_button "送出"

    expect(page).to have_text("任務已建立")
  end
  
  scenario "編輯任務" do
    # 這裡 卡了很久因為之前有 db:rollback 讓 status 欄位改為 integer,
    # 實際上看 log 也沒有看出問題，後來 db:reset 後就過了  
    # 參考資料: https://stackoverflow.com/questions/10301794/difference-between-rake-dbmigrate-dbreset-and-dbschemaload
    # visit '/' 把 root_path 放這裡 before @task is created, 
    # 會爆錯誤訊息 => Failure/Error: click_link "編輯" Capybara::ElementNotFound: Unable to find link "編輯"
    
    #先建立一件任務
    @task = Task.create(
      title: "Shopping",
      content: 'buy milk',
      task_begin: "2019-11-01 09:00:00",
      task_end: "2019-12-01 00:00:00",
      priority: "urgent",
      status: "proceeding")
    
    ## 作法ㄧ
    visit '/'
    click_button "編輯"
    fill_in 'task_content', with: 'apple'
    click_button "送出"
    
    expect(page).to have_content("apple")
    expect(current_path).to eq(tasks_path)
    expect(page).to have_text("編輯成功")

    ## 作法二
    # visit edit_task_path(@task.id)
    # fill_in 'task_content', with: 'apple'
    # click_button "送出"
    # expect(page).to have_content("apple")
    # expect(current_path).to eq(tasks_path)
    # expect(page).to have_text("編輯成功")
    
  end

  scenario "刪除任務" do
    @task = Task.create(title: "Shopping",
      content: 'buy milk',
      task_begin: "2019-11-01 09:00:00",
      task_end: "2019-11-01 00:00:00",
      priority: "medium",
      status: "pending")
    visit '/'
    click_button "刪除"

    expect(page).not_to have_content("Shopping")
    expect(page).to have_text("刪除成功")
  end
end


