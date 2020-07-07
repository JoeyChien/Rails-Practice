class TasksController < ApplicationController
  before_action :find_task, only: [:edit, :update, :destroy]

  def index
    # 之後加上分頁功能
    @tasks = Task.all.order(created_at: :desc)
  end

  def new
    @task = Task.new 
  end
  
  def create
    @task = Task.new(task_params) 
    if @task.save
      redirect_to tasks_path, notice: I18n.t('message.create_success')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: I18n.t('message.update_success')
    else
      render :edit
    end
  end

  def destroy
    if @task.destroy
      redirect_to tasks_path, notice: I18n.t('message.delete_success')
    else
      render :edit
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
