require 'test_helper'

class TimerTest < ActiveSupport::TestCase
  def setup
    @timer = FactoryGirl.create(:timer)
    @timer_with_moments = FactoryGirl.create(:timer_with_moments)
  end

  test 'reponders' do
    assert_respond_to @timer, :project
  end

  test '#time returns the total tracked time' do
    assert_equal @timer_with_moments.time, 5.hours
  end

  test '#start creates a moment' do
    assert_equal 0, @timer.moments.length
    @timer.start
    assert_equal 1, @timer.moments.length
  end

  test '#start does not run if it is already running for less than 3 seconds' do
    assert_equal 0, @timer.moments.length
    @timer.start
    @timer.start
    assert_equal 1, @timer.moments.length
  end

  test '#running? returns true if the timer is running' do
    @timer.start
    assert @timer.running?
  end

  test '#stopped? returns true if the timer is stopped' do
    assert @timer.stopped?
  end

  test '#stop stops the last moment' do
    assert_equal false, @timer.running?
    assert_equal 0, @timer.moments.length

    @timer.start
    assert_equal 1, @timer.moments.length
    assert @timer.running?

    @timer.stop
    assert @timer.moments.last.end_time
    assert_not @timer.running?
  end
end
