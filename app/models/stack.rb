class Stack < ActiveRecord::Base
  belongs_to :user
  belongs_to :company
  has_many :tasks, dependent: :destroy
  attr_accessible :name
  
  def to_param
  	name.parameterize
  end
end
