class Project < ActiveRecord::Base
  include TimerTotals

  belongs_to :client
  has_many :timers
  has_and_belongs_to_many :users

  validates :name, presence: true
end
