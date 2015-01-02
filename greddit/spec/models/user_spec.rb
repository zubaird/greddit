require 'rails_helper'


describe User do

  def make_user(options = {})
    options = {
      username: "Swan",
      email: "thing@thing.com",
      password: "test",
      password_confirmation: "test",
    }.merge(options)

    User.new(
    username: options[:username],
    email: options[:email],
    password: options[:password],
    password_confirmation: options[:password_confirmation],
    )
  end

  describe "the user model" do
    before do
      @user = make_user
    end

    it "responds to proper methods and attributes" do
      expect(@user.respond_to? "username" ).to eq(true)
      expect(@user.respond_to? "email" ).to eq(true)
      expect(@user.respond_to? "password" ).to eq(true)
      expect(@user.respond_to? "password_confirmation" ).to eq(true)
      expect(@user.respond_to? "posts" ).to eq(true)
      expect(@user.respond_to? "comments" ).to eq(true)
    end
  end

  describe "with valid info" do
    before do
      @user = make_user
    end

    it "should save" do
      expect(@user.save).to eq(true)
    end
  end

  describe "with blank username" do
    before do
      @user = make_user(username: "")
    end

    it "should not save" do
      expect(@user.save).to eq(false)
    end
  end

  describe "with blank email" do
    before do
      @user = make_user(email: "")
    end

    it "should not save" do
      expect(@user.save).to eq(false)
    end
  end

  describe "with blank password" do
    before do
      @user = make_user(password: "")
    end

    it "should not save" do
      expect(@user.save).to eq(false)
    end
  end

  describe "with incorrect password" do
    before do
      @user = make_user(
      password: "onething",
      password_confirmation: "anothething"
      )
    end

    it "should not save" do
      expect(@user.save).to eq(false)
    end
  end



end
