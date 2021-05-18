module TasksHelper
  def choose_new_or_edit
    if action_name == 'new'
      tasks_path
    else action_name == 'edit'
      task_path
    end
  end
end
