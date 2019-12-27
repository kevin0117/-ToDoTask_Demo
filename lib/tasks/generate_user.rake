namespace :user do
    desc '產生 100 筆樣本任務'
    task :generate => :environment do
      puts "generating users..."
      100.times { FactoryBot.create(:user) }
      puts "done"
    end
  end

#   終端機指令
#   rails user:generate
#   
#   約5000筆資料後，在 rails console 裡，用explain指令會看出建立 search index 的差別