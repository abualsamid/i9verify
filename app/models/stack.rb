class Stack < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :scoped, scope: :user
  	belongs_to :user
  	belongs_to :company
  	has_many :tasks, dependent: :destroy
  	attr_accessible :name
  	validates_uniqueness_of :name, scope:  [:user_id]
  
end
