class LabelsController < ApplicationController
  def index
    @labels = Label.where(user_id: current_user.id).or( Label.where(user_id: nil))
  end
  def new
    @label = Label.new
  end
  def create
    @label = current_user.labels.create(label_params)
    if @label.save
      redirect_to labels_path, notice: "Label Created!"
    else
      render :new
    end
  end
  def destroy
    @label = Label.find(params[:id])
    @label.destroy
    redirect_to tasks_path, notice: "Label Deleted!"
  end
  private
  def label_params
    params.require(:label).permit(:name)
  end
end
