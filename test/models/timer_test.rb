require 'test_helper'

class TimerTest < ActiveSupport::TestCase
  def setup
    @timer = FactoryGirl.create(:timer)
  end

  test 'reponders' do
    assert_respond_to @timer, :project
    assert_respond_to @timer, :end_time
  end

  test '#time returns the total tracked time' do
    @timer.end_time = Time.parse("12:00")
    assert @timer.time
  end

  test '#running? returns true if the timer is running' do
    assert @timer.running?
  end

  test '#stopped? returns true if the timer is stopped' do
    @timer.end_time = Time.now
    assert @timer.stopped?
  end

  test '#state returns the state of the timer' do
    assert_equal 'running', @timer.state

    @timer.end_time = Time.now
    assert_equal 'stopped', @timer.state
  end
end
