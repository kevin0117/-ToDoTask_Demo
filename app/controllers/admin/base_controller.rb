class Admin::BaseController < ApplicationController
    # https://railsbook.tw/chapters/25-organize-your-code.html
    # before_action :do_something

    # private
    # def do_something
    #   #....
    # end

    before_action :admin_check

    private
    def admin_check
      if !current_user.admin
        redirect_to user_tasks_path(current_user), notice: "權限不足"
      end
    end
    
end