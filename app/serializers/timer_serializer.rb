class TimerSerializer < ActiveModel::Serializer
  attributes :id, 
    :total_time,
    :created_at,
    :total_value,
    :start_time,
    :activity,
    :invoiced_at,
    :paid_at

  has_one :project
  has_one :client

  # TO BE TESTED
  def invoiced
    object.invoiced_at ? true : false
  end

  # TO BE TESTED
  def paid
    object.paid_at ? true : false
  end
end
