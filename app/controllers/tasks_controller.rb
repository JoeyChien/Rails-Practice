class TasksController < ApplicationController
  before_action :find_task, only: [:edit, :update, :destroy]

  def index
    # 之後加上分頁功能
    list_tasks
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
    params.require(:task).permit(:title, :content, :end_time, :status, :priority)
  end

  def find_task
    @task = Task.find_by(id: params[:id])
  end
  
  def sort_by
    %w{end_time created_at priority}.include?(params[:sort_by]) ? params[:sort_by] : 'created_at'
  end

  def direction
    %w{desc asc}.include?(params[:direction]) ? params[:direction] : 'desc'
  end

  def list_tasks
    @tasks = Task.order("#{sort_by} #{direction}")
    @tasks = @tasks.filter_by_status(params[:status]) if params[:status].present?
    @tasks = @tasks.query_by_title(params[:keyword]) if params[:keyword].present?
    @tasks = @tasks.page(params[:page])
  end
end
