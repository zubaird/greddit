require 'rails_helper'

def sign_in_user
  @user = User.create(
  username:"test-user",
  email:"test@example.com",
  password:"test",
  password_confirmation: "test",
  )

  visit root_path

  click_link 'Sign In'

  fill_in('Email', :with => 'test@example.com')
  fill_in('Password', :with => 'test')

  click_button 'Sign In'
end

def sign_in_user_alternate
  @user = User.create(
  username:"test-user-alternate",
  email:"test2@example.com",
  password:"test",
  password_confirmation: "test",
  )

  visit root_path

  click_link 'Sign In'

  fill_in('Email', :with => 'test2@example.com')
  fill_in('Password', :with => 'test')

  click_button 'Sign In'
end

def sign_out_user(user = "test-user")
  click_link "sign out - #{user}"
end

def sign_in_and_create_post(title = "test",content = "test content")
  sign_in_user

  visit root_path
  click_link "Add Post"

  fill_in('Title', :with => title)
  fill_in('Content', :with => content)

  click_button 'Create Post'
end

def create_and_goto_post
  sign_in_and_create_post("test title", "test content")
  click_link "Title - test title"
end


def add_comment(comment = "test comment")
  fill_in('comment_body', :with => comment)

  click_button 'Create Comment'
end

feature "New Post Page" do

  scenario "when user is not logged in" do
    visit new_post_path

    expect(page).to have_content("Please sign-in first")
  end

  scenario "when user is logged in" do
    sign_in_user

    visit root_path
    click_link "Add Post"

    expect(page).to have_content("Create Post")
  end

  scenario "when a new post is created" do
    sign_in_and_create_post("test title", "test content")

    expect(page).to have_content("test title")
  end

end

feature "Show Post Page" do

  scenario "when user is the post owner" do
    sign_in_and_create_post("test title", "test content")

    click_link "Title - test title"

    expect(page).to have_link 'Delete'
    expect(page).to have_link "Edit"
  end

  scenario "when user is the NOT post owner" do
    sign_in_and_create_post("test title", "test content")

    sign_out_user
    click_link "Title - test title"

    expect(page).to_not have_link "Delete"
    expect(page).to_not have_link "Edit"
  end

  scenario "it shows all the comments for that post" do
    create_and_goto_post
    add_comment("blah")

    expect(page).to have_content("blah")
    expect(page).to have_content("comment by test-user")
    expect(page).to have_selector("#delete-#{Comment.first.id}")
  end

  scenario "only comment owners can delete their own comments" do
    create_and_goto_post
    add_comment("blah")
    sign_out_user
    sign_in_user_alternate

    click_link "Title - test title"

    expect(page).to have_content("blah")
    expect(page).to_not have_selector("#delete-#{Comment.first.id}")
  end

end

feature "Edit Post Page" do

  scenario "the page allows editing of title" do
    create_and_goto_post

    click_link "Edit"
    fill_in('Title', :with => "New Title")
    click_button 'Update'

    expect(page).to have_content("Update Successful")
    expect(page).to have_content("New Title")
  end

  scenario "the page allows editing of content" do
    create_and_goto_post

    click_link "Edit"
    fill_in('Content', :with => "New Content")
    click_button 'Update'
    click_link "Title - test title"

    expect(page).to have_content("New Content")
  end

  scenario "does not edit for non post-owner" do
    create_and_goto_post
    sign_out_user
    sign_in_user_alternate

    visit edit_post_path(Post.first)

    expect(page).to have_content("You can't edit that!")
    expect(page).to have_title("Greddit")
  end

end
