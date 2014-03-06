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

  def self.to_csv
    CSV.generate do |csv|
      csv << ['Client', 'Project', 'Date', 'Minutes','Activity','Euro']
      all.each do |timer|
        csv << [
          timer.client ? timer.client.company_name : 'not defined',
          timer.project.name,
          "#{timer.created_at.strftime('%a %d %b %Y')}",
          self.parse_seconds(timer.total_time),
          timer.activity,
          "#{timer.total_value / 100}" ]
      end
    end
  end

  def self.parse_seconds(seconds)
    mins    = (seconds / 60).floor
    # hours   = (mins / 60).floor
    # minutes = (mins % 60).floor
    return "#{mins}" 
  end

  private

  def update_totals
    if project
      update_client
      update_project
    end
  end

  def update_client
    project.client.calculate_totals if project.client
  end

  def update_project
    project.calculate_totals
  end
end
