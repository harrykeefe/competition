require 'test_helper'

class ContestTest < ActiveSupport::TestCase

  test "should save with a valid name" do
    user = users(:paid_user)
    contest = user.contests.build(name: "Test Contest")
    assert contest.save
  end

  test "should not save with empty name" do
    user = users(:paid_user)
    contest = user.contests.build
    contest.valid?
    assert_not_empty contest.errors[:name]
  end

  test "free account should not allow 4 prizes" do
    user = users(:free_user)
    contest = user.contests.build
    4.times do 
      contest.prizes.build(name: "Prizes", value: "0.0")
    end

    assert_not contest.save
  end

  test "free account should allow 3 prizes" do
    user = users(:free_user)
    contest = user.contests.build(name: "Test Contest")
    3.times do 
      contest.prizes.build(name: "Prizes", value: "0.0")
    end

    assert contest.save
  end

  test "should properly calculate total value of prizes" do 
    user = users(:free_user)
    contest = user.contests.build
    4.times do 
      contest.prizes.build(name: "Prizes", value: "10.0")
    end

    assert_equal 40.0, contest.total_prize_value
  end

end
