class TimerSerializer < ActiveModel::Serializer
  attributes :id, 
    :total_time,
    :created_at,
    :total_value,
    :start_time,
    :activity,
    :invoiced_at,
    :paid_at,
    :tag

  has_one :project
  has_one :client

  # TO BE TESTED
  def tag
    return 'paid'     if object.paid_at
    return 'invoiced' if object.invoiced_at
    return ''
  end
end
