class TasksController < ApplicationController
  before_action :find_task, only: [:show, :edit, :update, :destroy]
  before_action :login_check
  before_action :same_user_check, only: [:edit,:update, :destroy]

  def index
    @q = Task.includes(:user).ransack(params[:q])
    @tasks = @q.result(distinct: true).page params[:page]
    # @tasks = current_user.tasks
    # @result_count = @tasks.count
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    # debugger
    if @task.save
      redirect_to '/tasks', notice: "任務已建立"
    else
      @error_message = @task.errors.full_messages.to_sentence
      flash[:notice] = "建立失敗"
      render :new, notice: "建立失敗"  
      #這裡的 render :new, notice: "建立失敗"
      #其實是類似 render partial 的概念， 把 notice:"建立失敗" 當參數帶進去
      #所以後面的 notice:"建立失敗 是沒有作用的
      # <%= render 'form', task: @task %>
      # debugger
    end
  end

  def edit  
  end
  
  def update
    if @task.update(task_params)
      redirect_to '/tasks', notice: "編輯成功"
    else
      @error_message = @task.errors.full_messages.to_sentence
      flash[:notice] = "編輯失敗"
      render :edit 
    end
    # debugger
  end
  
  def destroy
    @task.destroy
    redirect_to '/tasks', notice: "刪除成功"
  end

  def user
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true).page params[:page]
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :task_begin, :task_end, :priority, :status, :user)
  end
  
  def find_task
    @task = Task.find_by(id: params[:id])
  end

  
end