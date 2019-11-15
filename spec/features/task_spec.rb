require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  scenario "新增任務" do
    visit '/'

    click_button "新增任務"
    expect(current_path).to eq(new_task_path)

    fill_in "task_title", with: "Shopping"
    fill_in "task_content", with: "buy milk"
    fill_in "task_task_begin", with: "2019-11-01 09:00:00"
    fill_in "task_task_end", with: "2019-11-01 00:00:00"
    choose "task[priority]", with: "medium"
    choose "task[status]", with: "pending"
    
    click_button "Create Task"

    expect(page).to have_text("任務已建立")
  end
  
  scenario "編輯任務" do
    # visit '/' 把 root_path 放這裡 before @task is created, 
    # 會爆錯誤訊息 => Failure/Error: click_link "編輯" Capybara::ElementNotFound: Unable to find link "編輯"
    @task = Task.create(title: "Shopping",
      content: 'buy milk',
      task_begin: "2019-11-01 09:00:00",
      task_end: "2019-11-01 00:00:00",
      priority: "medium",
      status: "pending")

    visit '/'
    click_button "編輯"
    fill_in 'task_title', with: 'testing'
    click_button "Update Task"
    
    expect(page).to have_content("testing")
    expect(page).to have_text("編輯成功")
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


