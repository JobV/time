class Client < ActiveRecord::Base
  include TimerTotals
  
  has_many :projects
  has_many :timers, through: :projects
  has_and_belongs_to_many :users, -> { uniq }

  validates :company_name, presence: true
end
