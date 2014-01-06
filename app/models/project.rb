class Project < ActiveRecord::Base
  belongs_to :client
  has_and_belongs_to_many :users
  has_many :timers
  validates :name, presence: true
end
