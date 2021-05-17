class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  def show
    @task = Task.find(params [:id])
    @label = Label.where(task_id: params[:id])
  end
end
