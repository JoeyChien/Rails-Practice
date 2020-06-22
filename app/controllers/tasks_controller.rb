class TasksController < ApplicationController
  def index
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
    @task = Task.find_by(id: params[:id])
  end

  def update
    @task = Task.find_by(id: params[:id])

    if @task.update(task_params)
      redirect_to tasks_path, notice: "修改成功"
    else
      render edit, notice: "請再檢查資料"
    end
  end

  def destroy
    @task = Task.find_by(id: params[:id])

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
end
