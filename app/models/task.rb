class Task < ActiveRecord::Base
	belongs_to :stack 
	belongs_to :user
  	attr_accessible :description, :due, :name, :priority, :status_id
	validates :stack_id, presence: true
	validates :user_id, presence: true
	validates :company_id, presence: true
	validates :name, presence: true	
	validates_presence_of :name
	default_scope order: 'tasks.status_id, tasks.due DESC, tasks.priority'
end
