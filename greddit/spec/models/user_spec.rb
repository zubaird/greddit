require 'rails_helper'


describe User do

  describe "with valid info" do
    before do
      @user = User.new(
      username: "Swan",
      email: "thing@thing.com",
      password: "test",
      password_confirmation: "test",
      )
    end

    it "should save" do
      expect(@user.save).to eq(true)
    end
  end

  describe "with blank username" do
    before do
      @user = User.new(
      username: "",
      email: "thing@thing.com",
      password: "test",
      password_confirmation: "test",
      )
    end

    it "should not save" do
      expect(@user.save).to eq(false)
    end
  end

  describe "with blank email" do
    before do
      @user = User.new(
      username: "Test",
      email: "",
      password: "test",
      password_confirmation: "test",
      )
    end

    it "should not save" do
      expect(@user.save).to eq(false)
    end
  end

  describe "with blank password" do
    before do
      @user = User.new(
      username: "Test",
      email: "test@test.com",
      password: "",
      password_confirmation: "",
      )
    end

    it "should not save" do
      expect(@user.save).to eq(false)
    end
  end

  describe "with incorrect password" do
    before do
      @user = User.new(
      username: "Test",
      email: "test@test.com",
      password: "test-incorrect",
      password_confirmation: "test",
      )
    end

    it "should not save" do
      expect(@user.save).to eq(false)
    end
  end



end
