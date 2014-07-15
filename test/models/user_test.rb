require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  should have_many(:user_friendships)
  should have_many(:friends)

  test "a user should enter a first name" do
    user = User.new
    assert !user.save
    assert !user.errors[:first_name].empty?
  end

  test "a user should enter a last name" do
    user = User.new
    assert !user.save
    assert !user.errors[:last_name].empty?
  end

  test "a user should enter a profile name" do
    user = User.new
    assert !user.save
    assert !user.errors[:profile_name].empty?
  end

  test "a user should have a unique profile name" do
    user = User.new
    user.profile_name = users(:jd).profile_name

    assert !user.save
    assert !user.errors[:profile_name].empty?
  end

  test "a user should have a profile name without spaces" do
    user = User.new
    user.profile_name = "My profile With Spaces"

    assert !user.save
    assert !user.errors[:profile_name].empty?
    assert user.errors[:profile_name].include?("Must be formatted correctly.")
  end

  # test "a user can have a correctly formatted profile name" do
  #   user = User.new(first_name: 'J', last_name: 'D', email: 'djrlthu@gmail.com')
  #   user.password = user.password_confirmation = 'kktcondition'
  #   user.profile_name = 'JD_1J'
  #   assert user.valid?
  # end

    test "that no error is raised when trying to access a friend list" do
      assert_nothing_raised do
        users(:jd).friends
      end
    end


    test "that creating friendships on a user works" do
      users(:jd).friends << users(:zz)
      users(:jd).friends.reload
      assert users(:jd).friends.include?(users(:zz))
    end

    test "that creating a friendship based on user id and friend id works" do
      UserFriendship.create user_id: users(:jd).id, friend_id: users(:zz).id
      assert users(:jd).friends.include?(users(:zz))
    end

    test "that calling to_param on a user returns the profile name" do 
      assert_equal "JJ", users(:jd).to_param
    end
end
