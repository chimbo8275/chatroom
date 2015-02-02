class Message < ActiveRecord::Base
	belongs_to :author, class_name: 'User'
	belongs_to :room

	validates :author, presence: true

end
