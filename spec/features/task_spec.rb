require 'rails_helper'

RSpec.feature "Tasks", type: :feature do

  describe "功能測試" do 
    before do
      task_1 = Task.create(title: "task_1",
          content: 'buy milk',
          task_begin: "Tue, 26 Nov 2019 01:13:00 CST +08:00",
          task_end: "Tue, 27 Nov 2019 01:13:00 CST +08:00",
          priority: "medium",
          status: "pending")
          
      task_2 = Task.create(title: "task_2",
          content: 'buy milk',
          task_begin: "Tue, 21 Nov 2019 01:13:00 CST +08:00",
          task_end: "Tue, 29 Nov 2019 01:13:00 CST +08:00",
          priority: "medium",
          status: "pending")
    end

    # scenario "任務列表以建立時間排序" do
    #   visit '/'
    #   within 'tr:nth-child(2)' do
    #     expect(page).to have_content("task_2") 
    #   end
    #   within 'tr:nth-child(3)' do
    #     expect(page).to have_content("task_1") 
    #   end
    # end

    scenario "任務列表以結束時間排序" do
      visit '/'
      within 'tr:nth-child(2)' do
        expect(page).to have_content("task_1") 
      end
      within 'tr:nth-child(3)' do
        expect(page).to have_content("task_2") 
      end
    end
    
    scenario "新增任務" do
        visit '/'
    
        click_button "新增任務"
        expect(current_path).to eq(new_task_path)
    
        fill_in "task_title", with: "Shopping"
        fill_in "task_content", with: "buy milk"
        select '2018', from: 'task_task_begin_1i'
        select '2019', from: 'task_task_end_1i'
        select '不急', from: 'task_priority'
        select '已完成', from: 'task_status'
    
        click_button "送出"
    
        expect(page).to have_text("任務已建立")
    end

    scenario "新增任務失敗" do
        visit '/'
    
        click_button "新增任務"
        expect(current_path).to eq(new_task_path)
    
        fill_in "task_title", with: "Shopping"
        fill_in "task_content", with: "buy milk"
        select '2018', from: 'task_task_begin_1i'
        select '2017', from: 'task_task_end_1i'
        select '不急', from: 'task_priority'
        select '已完成', from: 'task_status'
    
        click_button "送出"
    
        expect(page).to have_text("建立失敗")
    end

    # 這裡 卡了很久因為之前有 db:rollback 讓 status 欄位改為 integer,
    # 實際上看 log 也沒有看出問題，後來 db:reset 後就過了  
    # 參考資料: https://stackoverflow.com/questions/10301794/difference-between-rake-dbmigrate-dbreset-and-dbschemaload
    # visit '/' 把 root_path 放這裡 before @task is created, 
    # 會爆錯誤訊息 => Failure/Error: click_link "編輯" Capybara::ElementNotFound: Unable to find link "編輯"
        
    scenario "編輯任務" do
        visit '/'
        within 'tr:nth-child(2)' do
          click_button "編輯"
        end
        fill_in 'task_content', with: 'apple'
        click_button "送出"
        
        expect(page).to have_content("apple")
        expect(current_path).to eq(tasks_path)
        expect(page).to have_text("編輯成功")
    end

    scenario "編輯任務失敗" do
        visit '/'
        within 'tr:nth-child(2)' do
          click_button "編輯"
        end
        fill_in 'task_content', with: ''
        click_button "送出"
        
        expect(page).not_to have_content("apple")
        expect(page).to have_text("編輯失敗")
    end

    scenario "刪除任務" do
        visit '/'
        within 'tr:nth-child(3)' do
          click_button "刪除"
        end
        expect(page).not_to have_content("task_2")
        expect(page).to have_text("刪除成功")
    end
  end
end


