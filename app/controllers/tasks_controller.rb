class TasksController < ApplicationController
  before_action :find_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    # debugger
    @task = Task.new(task_params)

    if @task.save
      redirect_to '/tasks', notice: "任務已建立"
    else
      render :new  
    end
  end

  def edit    
  end
  
  def update
    if @task.update(task_params)
      redirect_to '/tasks', notice: "編輯成功"
    else
      render :edit
    end
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