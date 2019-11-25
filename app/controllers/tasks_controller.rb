class TasksController < ApplicationController
  before_action :find_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    
    # debugger
    if @task.save
      redirect_to '/tasks', notice: "任務已建立"
    else
      @error_message = @task.errors.full_messages
      render :new, notice: "建立失敗" 
      # debugger
    end
  end

  def edit    
  end
  
  def update
    if @task.update(task_params)
      redirect_to '/tasks', notice: "編輯成功"
    else
      @error_message = @task.errors.full_messages
      render :edit, notice: "編輯失敗" 
    end
    # debugger
  end
  
  def destroy
    @task.destroy
    redirect_to '/tasks', notice: "刪除成功"
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :task_begin, :task_end, :priority, :status)
  end
  
  def find_task
    @task = Task.find_by(id: params[:id])
  end
end