class TasksController < ApplicationController
  def index
    @tasks = Task.all
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
    @task = Task.find_by(id: params[:id])    
  end
  
  def update
    @task = Task.find_by(id: params[:id])
    if @task.update(task_params)
      redirect_to '/tasks', notice: "編輯成功"
    else
      render :edit
    end
  end
  
  def destroy
    @task = Task.find_by(id: params[:id])
    @task.destroy
    redirect_to '/tasks', notice: "刪除成功"
  end
  private
  def task_params
    params.require(:task).permit(:title, :content, :task_begin, :task_end, :priority, :status)
  end 
end