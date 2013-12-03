require 'spec_helper'

describe Timer do
  ATTRIBUTES = [:total_time, :written_time, :end_time, :project, :user_id]
  specify do
    ATTRIBUTES.each do |attr|
      expect(subject).to respond_to(attr)
    end
  end
end
