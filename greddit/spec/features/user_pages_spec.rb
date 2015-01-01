require 'rails_helper'

feature "Sign Up Page" do

  scenario "is the correct page" do
    visit new_user_path

    expect(page).to have_content("email")
  end

end

feature "When user signs up" do

  scenario "fills in correct information" do
    visit root_path

    click_link 'Sign Up'

    fill_in('Username', :with => 'John')
    fill_in('Email', :with => 'blah@blah.com')
    fill_in('Password', :with => 'Seekrit')
    fill_in('Password confirmation', :with => 'Really Long Text...')

    click_button 'Create User'

    expect(page).to have_content("Show Page")
    expect(page).to have_content("John")
    expect(page).to have_content("blah@blah.com")
  end

end
