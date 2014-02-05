class ProjectSerializer < ActiveModel::Serializer
  attributes :id, 
    :name, 
    :hourly_rate, 
    :created_at,
    :updated_at,
    :uninvoiced,
    :invoiced,
    :paid,
    :uninvoiced_time,
    :invoiced_time,
    :paid_time

  has_one :client
end
