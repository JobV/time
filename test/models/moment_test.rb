require 'test_helper'

class MomentTest < ActiveSupport::TestCase
  def setup
    @moment = FactoryGirl.create(:moment)
    @ended_moment = FactoryGirl.create(:ended_moment)
  end
  
  test 'reponds' do
    assert_respond_to @moment, :end_time
  end

  test '#time returns the total lenght of this moment' do
    assert_equal @ended_moment.time, 1.hour
  end

  test '#time returns the time up until now if no end_time is set' do
    assert_not_nil @moment.time
  end

  test '#ended? returns true if the moment is over' do
    assert_equal true, @ended_moment.ended?
  end

  test '#ended? returns false if the moment is not over' do
    @moment.end_time = nil
    assert_not @moment.ended?
  end

  test '#stop sets the end_time if it has not been set' do
    @moment.end_time = nil
    @moment.stop
    assert_not_nil @moment.end_time
  end

  test '#stop does not set the end_time if it has been set' do
    time_a = Time.parse("12:00")
    time_b = Time.parse("14:00")
    @moment.end_time = time_a
    @moment.stop(time_b)
    assert_not_equal @moment.end_time, time_b
  end

  test '#running? returns true if end_time has not been set' do
    @moment.end_time = nil
    assert_equal true, @moment.running?
  end
end
