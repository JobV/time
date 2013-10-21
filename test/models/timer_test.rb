require 'test_helper'

class TimerTest < ActiveSupport::TestCase
  def setup
    @timer = FactoryGirl.create(:timer)
  end

  test 'reponders' do
    assert_respond_to @timer, :project
    assert_respond_to @timer, :end_time
    assert_respond_to @timer, :total_time
  end

  test '#time returns the total tracked time' do
    assert @timer.time
  end

  test '#set_total_time sets the total_time' do
    @timer.stop
    assert @timer.total_time
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
