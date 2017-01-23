module TasksHelper
  def completed_link_text(model)
  	if model.completed?
  		'Completed'
  	elsif model.deadline and model.deadline.past?
  		'Overdue'
  	else
  		'On-going'
  	end
  end

  def completed_link_data_order(model)
  	if model.completed?
  		2
  	elsif model.deadline and model.deadline.past?
  		1
  	else
  		0
  	end
  end

end
