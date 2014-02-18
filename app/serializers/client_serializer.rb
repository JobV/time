class ClientSerializer < ActiveModel::Serializer
  attributes :id, 
    :company_name, 
    :created_at, 
    :updated_at,
    :uninvoiced,
    :invoiced,
    :paid,
    :uninvoiced_time,
    :invoiced_time,
    :paid_time,
    :projects
end
