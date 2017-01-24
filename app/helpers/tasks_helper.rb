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

  def pretty_print_deadline(model)
    diff = distance_of_time_in_words_to_now(model.deadline)
    if model.deadline
      if model.deadline - DateTime.now < 0
        diff + ' ago'
      else
        'in ' + diff
      end
    else
      "No deadline"
    end
  end

end
