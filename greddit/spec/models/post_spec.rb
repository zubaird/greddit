require 'rails_helper'

describe Post do

  describe "when post is valid" do
    before do
      @post = Post.new(
      title: "Test Title",
      content: "Test Content",
      )
    end
    it "should save" do
      expect(@post.save).to eq(true)
    end
  end

  describe "when post is missing a title" do
    before do
      @post = Post.new(
      title: "",
      content: "Test Content",
      )
    end
    it "should not save" do
      expect(@post.save).to eq(false)
    end
  end

  describe "when post is missing content" do
    before do
      @post = Post.new(
      title: "Test Title",
      content: "",
      )
    end
    it "should not save" do
      expect(@post.save).to eq(false)
    end
  end


end
