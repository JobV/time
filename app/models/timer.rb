class Timer < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  belongs_to :client

  attr_accessor :written_time

  after_save    :update_totals
  after_destroy :update_totals

  after_initialize :set_time

  def parse_time
    ChronicDuration.parse(written_time) if written_time
  end

  def set_time
    total_time_will_change!
    total_time = parse_time
  end

  private

  def update_totals
    update_client
    update_project
  end

  def update_client
    client.calculate_totals  if client
  end

  def update_project
    project.calculate_totals if project
  end
end
