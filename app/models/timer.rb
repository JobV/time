class Timer < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  belongs_to :client

  attr_accessor :written_time

  after_initialize :set_time

  def parse_time
    ChronicDuration.parse(written_time) if written_time
  end

  def set_time
    total_time_will_change!
    total_time = parse_time
  end
end
