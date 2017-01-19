module TasksHelper
  def completed_link_text(model)
    model.completed? ? 'Completed' : 'On-going'
  end

end
