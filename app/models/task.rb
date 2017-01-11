class Task < ApplicationRecord

	before_save :remove_blank_tasks

	validates :title, presence: true

	def remove_blank_tasks
		tags.reject!(&:blank?)
	end
	# def set_deadline_to_now
	#   self.deadline = Time.now
	# end
end
