require 'rails_helper'

feature "When user signs up" do

  scenario "fills in correct information" do
    visit root_path

    click_link 'Sign Up'

    fill_in('Username', :with => 'John')
    fill_in('Email', :with => 'blah@blah.com')
    fill_in('Password', :with => 'Seekrit')
    fill_in('Password confirmation', :with => 'Seekrit')

    click_button 'Create User'

    expect(page).to have_content("Show Page")
    expect(page).to have_content("John")
    expect(page).to have_content("You have successfully been signed up")
  end

end
