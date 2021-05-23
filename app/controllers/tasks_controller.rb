class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :show, :destroy, :update]
  def index
    @tasks = Task.all
    @tasks = @tasks.order(:created_at)
  end
  def new
    @task = Task.new
    @label = Label.all
  end
  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "TASK Created!"
    else
      render :new
    end
  end
  def show
    @label = Label.where(task_id: params[:id])
  end
  def edit
  end
  def update
    if @task.update_attributes(task_params)
      redirect_to tasks_path, notice: "TASK Updated!"
    else
      render :new
    end
  end
  def destroy
    @label = Label.find_by(task_id: params[:id])
    @label.destroy
    redirect_to tasks_path, notice: "TASK Deleted!"
  end
  private
  def set_task
    @task = Task.find(params[:id])
  end
  def task_params
    params.require(:task).permit(:title, :content, label_ids: [])
  end
end
