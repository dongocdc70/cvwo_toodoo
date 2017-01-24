class Task < ApplicationRecord

	before_save :remove_blank_and_duplicate_tags

	validates :title, presence: true

	def remove_blank_and_duplicate_tags
		tags.uniq!
		tags.reject!(&:blank?)
	end
	# def set_deadline_to_now
	#   self.deadline = Time.now
	# end
end
