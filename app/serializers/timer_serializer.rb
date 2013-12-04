class TimerSerializer < ActiveModel::Serializer
  attributes :id, :total_time, :created_at, :total_value
  has_one :project
end
