class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :hourly_rate, :created_at
  has_one :client
end
