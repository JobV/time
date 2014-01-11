class TimerSerializer < ActiveModel::Serializer
  attributes :id, :total_time, :created_at, :total_value, :start_time, :activity
  has_one :project
  has_one :client
end
