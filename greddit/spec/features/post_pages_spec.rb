require 'rails_helper'

def sign_in_user
  visit root_path

  click_link 'Sign In'

  fill_in('Email', :with => 'test@example.com')
  fill_in('Password', :with => 'test')

  click_button 'Sign In'
end

feature "New Post Page" do

  scenario "when user is not logged in" do
    visit new_post_path

    expect(page).to have_content("Please sign-in first")
  end

  scenario "when user is logged in" do
    sign_in_user

    visit new_post_path

    expect(page).to have_content("Create Post")
  end

end
