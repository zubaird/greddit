require 'rails_helper'

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
    expect(page).to have_content "created by: test-user (you)"
  end

  scenario "when user is the NOT post owner" do
    sign_in_and_create_post("test title", "test content")

    sign_out_user
    click_link "Title - test title"

    expect(page).to_not have_link "Delete"
    expect(page).to_not have_link "Edit"
    expect(page).to have_content "created by: test-user"
  end
end

feature "Comments" do
  scenario "it shows all the comments for that post" do
    create_and_goto_post
    add_comment("blah")

    expect(page).to have_content("blah")
    expect(page).to have_content("comment by test-user")
    expect(page).to have_selector("#delete-#{Comment.first.id}")
    expect(page).to have_selector("#edit-#{Comment.first.id}")
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

  scenario "when delete button is clicked for comment" do
    create_and_goto_post
    add_comment("blah")

    click_link "delete-#{Comment.first.id}"

    expect(page).to have_content("comment deleted successfully")
    expect(page).to have_title("Greddit")
  end

  scenario "only comment owners can edit their own comments" do
    create_and_goto_post
    add_comment("blah")
    sign_out_user
    sign_in_user_alternate

    click_link "Title - test title"

    expect(page).to have_content("blah")
    expect(page).to_not have_selector("#edit-#{Comment.first.id}")
  end

  scenario "when edit button is clicked for comment" do
    create_and_goto_post
    add_comment("blah")

    click_link "edit-#{Comment.first.id}"

    expect(page).to have_content("Edit Comment")
    expect(page).to have_title("Greddit")
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
