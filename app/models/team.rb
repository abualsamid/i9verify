class Team < ActiveRecord::Base
	belongs_to :user
	default_scope order: "name"	
	attr_accessible :description, :name
	validates :name, presence: true, uniqueness: {case_sensitive: false}
	validates_uniqueness_of :name, scope: :user_id, case_sensitive: false
end
