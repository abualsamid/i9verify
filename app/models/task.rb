class Task < ActiveRecord::Base
	belongs_to :stack 
	belongs_to :user
  	attr_accessible :description, :due, :name, :priority, :status_id, :duetime
	validates :stack_id, presence: true
	validates :user_id, presence: true
	validates :company_id, presence: true
	validates :name, presence: true	
	validates_presence_of :name
	default_scope order: 'tasks.status_id, tasks.due DESC, tasks.duetime desc, tasks.priority, tasks.created_at'
	def priority_star
		return "onestar" if self.priority == 10
		return "twostar" if self.priority == 20
		return "threestar" if self.priority == 30
		return "fourstar" if self.priority == 40
		return "fivestar" if self.priority == 50
		self.priority
	end
end
