require 'spec_helper'

describe User do
  after(:each) do
    User.delete_all
  end
  describe "adding user" do
    it "response should not be -1" do
      response = User.add("asdfasdfasdf","asdfasdf")
      response.should_not eql(-1)
    end
  end
  describe "adding multiple users" do
    it "responses should not equal -1" do
      response1 = User.add("asdf", "asdf")
      response2 = User.add("fdsa", "fdsa")
      response3 = User.add("zxcv","zxcv")
      response1.should_not eql(-1)
      response2.should_not eql(-1)
      response3.should_not eql(-1)
    end
  end
  describe "adding empty username" do
    it "response should equal -3" do
      response = User.add("","adsf")
      response.should eql(-3)
    end
  end
  describe "adding long username" do
    it "response should equal -3" do
      response = User.add('a'*300,"asdf")
      response.should eql(-3)
    end
  end
  describe "adding long password" do
    it "response should equal -4" do
      response = User.add("asdf",'a'*300)
      response.should eql(-4)
    end
  end
  describe "logging in successfully" do
    it "response should not be -1" do
      User.add("qwer","qwer")
      response = User.login("qwer","qwer")
      response.should_not eql(-1)
    end
  end
  describe "logging in with wrong info" do
    it "response should be -1" do
      User.add("ryan","ryan")
      response = User.login("ryan","wrong")
      response.should eql(-1)
    end
  end
  describe "login increases count successfully" do
    it "response should be 2" do
      User.add("hello","hello")
      User.login("hello","hello")
      response = User.find_by_user("hello").count
      response.should eql(2)
    end
  end
  describe "login doesn't increase with wrong login" do
    it "response should be 1" do
      User.add("bye","bye")
      User.login("bye","poop")
      response = User.find_by_user("bye").count
      response.should eql(1)
    end
  end
  describe "adding existing should not work" do
    it "response should be -2" do
      User.add("jello","jello")
      response = User.add("jello","jello")
      response.should eql(-2)
    end
  end
end
