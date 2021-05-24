class LabelsController < ApplicationController
  def new
    @label = Label.new
  end
  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to labels_path, notice: "Label Created!"
    else
      render :new
    end
  end
  private
  def label_params
    params.require(:label).permit(:pripority, :status, :category1, :category2, :category3)
  end
end
