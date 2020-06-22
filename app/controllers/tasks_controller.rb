class TasksController < ApplicationController
  before_action :find_task, only: [:edit, :update, :destroy]

  def index
    # 之後加上分頁功能
    @tasks = Task.all
  end

  def new
    @task = Task.new 
  end
  
  def create
    @task = Task.new(task_params) 
    if @task.save
      redirect_to tasks_path, notice: "新增成功"
    else
      render new, notice: "請再檢查資料"
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "修改成功"
    else
      render edit, notice: "請再檢查資料"
    end
  end

  def destroy
    if @task.destroy
      redirect_to tasks_path, notice: "刪除成功"
    else
      render edit, notice: "請再試一次"
    end
  end

  private
  def task_params
    params.require(:task).permit(:title, :content)
  end
  def find_task
    @task = Task.find_by(id: params[:id])
  end
end
