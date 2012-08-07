class Company < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :users, dependent: :destroy
end
